class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :plan
      t.integer :company_id
      t.string :stripe_customer_token
      t.timestamps
    end
  end
end
