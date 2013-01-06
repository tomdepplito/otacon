class MakeReceiverIdNotNull < ActiveRecord::Migration
  def up
    remove_column :conversations, :receiver_id
    add_column :conversations, :receiver_id, :integer
  end

  def down
  end
end
