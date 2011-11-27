class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :function
      t.string :email
      t.text :address
      t.string :zip
      t.string :city
      t.string :country
      t.string :phone1
      t.string :phone2
      t.string :picture
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
