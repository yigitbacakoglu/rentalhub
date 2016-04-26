class AddConnectionToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :connection, :boolean, default: false
    add_column :properties, :deleted_at, :datetime
    add_column :properties, :owner_email, :string
    add_column :properties, :owner_phone, :string
    add_column :properties, :owner_name, :string
    add_column :properties, :verification_token, :string
  end
end