class AddLocationToRfi < ActiveRecord::Migration
  def change
    add_column :conversations, :street_address, :string
  end
end
