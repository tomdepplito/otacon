class AddLatAndLongToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :latitude, :float
    add_column :conversations, :longitude, :float
  end
end
