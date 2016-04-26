class Property < ActiveRecord::Base

  belongs_to :user

  has_many :wish_lists, :dependent => :destroy
  has_many :leases, :dependent => :destroy

  has_many :images, as: :viewable

  validates :title, :description, :country, :city, :street1, :presence => true
  before_save :set_connection

  accepts_nested_attributes_for :images, allow_destroy: true

  scope :not_connection, -> { where(connection: false) }

  def self.deleted
    unscoped.where('deleted_at is not null')
  end

  def self.default_scope
    where(deleted_at: nil)
  end

  ransacker :location, formatter: proc { |v| v.mb_chars.downcase.to_s } do |parent|
    Arel::Nodes::InfixOperation.new('||',
                                    Arel::Nodes::InfixOperation.new('||', parent.table[:city], Arel::Nodes.build_quoted(', ')),
                                    parent.table[:country])
  end


  def self.locations
    Property.order(:city).pluck(:city, :country).uniq
  end

  def location
    "#{self.city}, #{self.country}"
  end

  def wished_by?(usr_id)
    self.wish_lists.where(user_id: usr_id).present?
  end

  def image
    (self.images.first || self.images.build).attachment
  end

  def connection_property?
    connection?
  end

  private

  def set_connection
    if User.current && User.current.tenant?
      self.connection = true
      self.verification_token ||= SecureRandom.hex 32
    end
  end

end
