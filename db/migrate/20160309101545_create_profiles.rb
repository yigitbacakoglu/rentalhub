class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :firstname
      t.string :lastname
      t.text :description
      t.string :business_name
      t.string :abn
      t.text :service_provided
      t.string :postcode
      t.text :reason
      t.boolean :terms

      t.timestamps null: false
    end
  end
end
