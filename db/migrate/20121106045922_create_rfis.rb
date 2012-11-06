class CreateRfis < ActiveRecord::Migration
  def change
    create_table :rfis do |t|
      t.integer :requestor_id
      t.integer :responder_id
      t.text    :body
      t.timestamps
    end
  end
end
