class User < ActiveRecord::Base
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  has_many :properties
  has_many :wish_lists
  has_one :profile

  scope :owner, -> { where(role: 'Owner') }
  scope :tenant,  -> { where(role: 'Tenant') }

  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true


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

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

  private

  def set_role
    if self.role == 'Admin' && User.current.present? && !User.current.admin?
      self.role = 'Tenant'
    end
  end



end
