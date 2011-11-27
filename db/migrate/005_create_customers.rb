class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :firstname
      t.string :lastname
      t.string :company
      t.string :function
      t.string :email
      t.text :adresse
      t.string :zip
      t.string :city
      t.string :country
      t.string :phone1
      t.string :phone2
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
