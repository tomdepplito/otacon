class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :street
      t.string :house_num
      t.string :zip
      t.string :state
      t.string :phone_num
      t.timestamps
    end
  end
end
