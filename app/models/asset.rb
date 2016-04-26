class Asset < ActiveRecord::Base
  belongs_to :viewable, polymorphic: true
  has_attached_file :attachment
  do_not_validate_attachment_file_type :attachment

  include Rails.application.routes.url_helpers

end
