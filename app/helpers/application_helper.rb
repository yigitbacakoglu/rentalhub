module ApplicationHelper

  def wishlist_link(property)
    return ''
    if property.wished_by?(@current_user.try(:id))
      link_to unwish_property_path(property), data: {remote: true, method: :put} do
        content_tag(:i, '', class: 'glyphicon glyphicon-star') +
            " Remove from Wish List"
      end
    else
      link_to wish_property_path(property), data: {remote: true, method: :put} do
        content_tag(:i, '', class: 'glyphicon glyphicon-star-empty') +
            " Add to Wish List"
      end
    end
  end

  def render_errors(target)
    render(partial: 'shared/errors', locals: {target: target}, formats: [:html])
  end

  def format_date(date = nil)
    return "" if date.nil?
    I18n.l date, format: "%d %B %Y, %T"
  end

  def standard_date(date = nil)
    return "" if date.nil?
    I18n.l date, format: :long
  end

  #Adds line breaks to text
  def format_text(text)
    h(text.to_s).gsub(/\n/, '<br>').html_safe
  end


  def active_if(bool)
    'active' if bool
  end

  def current_url(new_params = {}, except_params = [])
    ep = params.dup
    except_params.each do |p|
      ep.delete p
    end
    url_for ep.merge(new_params)
  end

  ALERT_TYPES = [:danger, :info, :success, :warning]

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?
      type = type.to_sym
      type = :info if type == :notice
      type = :danger if type == :error
      type = :warning if type == :alert
      next unless ALERT_TYPES.include?(type.to_sym)

      Array(message).each do |msg|
        text = content_tag(:div,
                           content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                               msg.html_safe, :class => "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash.sweep
    flash_messages.join("\n").html_safe
  end


end
