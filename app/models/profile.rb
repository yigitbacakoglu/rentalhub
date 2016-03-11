class Profile < ActiveRecord::Base
  belongs_to :user
  validates :terms, :presence => true


  def user_profile_percentage
    i = 0
    user_profile_fields.each do |f|
      i += 1 if self.send(f).present?
    end
    (i.to_f / user_profile_fields.count.to_f) * 100
  end

  def business_profile_percentage
    i = 0
    business_profile_fields.each do |f|
      i += 1 if self.send(f).present?
    end
    (i.to_f / business_profile_fields.count.to_f) * 100
  end

  def user_profile_fields
    %w(firstname lastname postcode)
  end

  def business_profile_fields
    %w(business_name service_provided abn business_postcode)
  end
end
