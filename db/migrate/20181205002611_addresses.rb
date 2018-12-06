class Addresses < ActiveRecord::Migration[5.2]
  def change
    drop_table :addresses
    
    create_table :addresses do |t|
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :address
      t.timestamps
    end
  end
end
