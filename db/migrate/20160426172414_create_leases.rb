class CreateLeases < ActiveRecord::Migration
  def change
    create_table :leases do |t|
      t.references :user, index: true, foreign_key: true
      t.references :property, index: true, foreign_key: true
      t.date :from_date
      t.date :to_date
      t.decimal :price
      t.timestamps null: false
    end
  end
end
