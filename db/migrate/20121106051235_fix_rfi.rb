class FixRfi < ActiveRecord::Migration
  def up
    remove_column :rfis, :responder_id
    remove_column :rfis, :requestor_id
    add_column    :rfis, :author_id, :integer
  end

  def down
  end
end
