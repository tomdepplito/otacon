class ChangeSubscriptionPlanDatatype < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :plan
    add_column :subscriptions, :plan, :string
  end

  def down
  end
end
