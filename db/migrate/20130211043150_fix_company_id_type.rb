class FixCompanyIdType < ActiveRecord::Migration
  def up
    remove_column :users, :company_id
    add_column :users, :company_id, :integer
  end

  def down
  end
end
