class Profile < ActiveRecord::Base
  belongs_to :user
  validates :terms, :presence => true

end
