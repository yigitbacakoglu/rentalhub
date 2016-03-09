class User < ActiveRecord::Base
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :properties
  has_many :wish_lists
  has_one :profile

  scope :owner, -> { where(role: 'Owner') }
  scope :tenant,  -> { where(role: 'Tenant') }

  before_save :set_role

  delegate :firstname, :lastname, :description, :business_name, to: :profile
  accepts_nested_attributes_for :profile

  def tenant?
    self.role == 'Tenant'
  end

  def admin?
    self.role == 'Admin'
  end

  def owner?
    self.role == 'Owner'
  end

  def provider?
    self.role == 'Provider'
  end

  def display_name
    if self.provider?
      business_name
    else
      fullname
    end
  end

  def self.current
    Thread.current[:user]
  end

  def self.current=(u)
    Thread.current[:user] = u
  end

  def fullname
    "#{self.firstname} #{self.lastname}"
  end

  private

  def set_role
    if self.role == 'Admin' && User.current.present? && !User.current.admin?
      self.role = 'Tenant'
    end
  end



end
