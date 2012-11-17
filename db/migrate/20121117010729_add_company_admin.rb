class AddCompanyAdmin < ActiveRecord::Migration
  def up
    add_column :companies, :admin_id, :integer
  end

  def down
  end
end
