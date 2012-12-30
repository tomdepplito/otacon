class FixSpecialtyLists < ActiveRecord::Migration
  def up
    remove_column :users, :vendor
    add_column :companies, :vendor, :boolean, :default => false
    remove_column :employees, :company_id
    add_column :employees, :company_id, :integer
    remove_column :specialty_lists, :user_id
    add_column :specialty_lists, :owner_id, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end

  def down
  end
end
