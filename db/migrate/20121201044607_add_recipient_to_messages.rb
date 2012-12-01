class AddRecipientToMessages < ActiveRecord::Migration
  def change
    drop_table :messages
    drop_table :rfis
  end
end
