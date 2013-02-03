class AddSubscriptionStatus < ActiveRecord::Migration
  def up
    add_column :subscriptions, :active, :boolean, :default => false
  end

  def down
  end
end
