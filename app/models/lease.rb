class Lease < ActiveRecord::Base
  belongs_to :user
  belongs_to :property


  def tenant
    self.user
  end

  def owner
    self.property.owner
  end

end
