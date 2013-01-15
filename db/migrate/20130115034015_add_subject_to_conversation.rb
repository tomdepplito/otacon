class AddSubjectToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :subject, :string
  end
end
