class AddLocToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :street_address
    end
  end
end
