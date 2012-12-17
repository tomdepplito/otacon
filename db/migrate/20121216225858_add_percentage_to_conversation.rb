class AddPercentageToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :match_percentage, :float
  end
end
