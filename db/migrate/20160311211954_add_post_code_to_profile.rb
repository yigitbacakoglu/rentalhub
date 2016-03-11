class AddPostCodeToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :business_postcode, :string
  end
end
