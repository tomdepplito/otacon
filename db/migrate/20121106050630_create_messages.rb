class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :rfi_id
      t.integer :author_id
      t.text    :body
      t.timestamps
    end
  end
end
