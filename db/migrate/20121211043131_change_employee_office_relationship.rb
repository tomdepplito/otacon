class ChangeEmployeeOfficeRelationship < ActiveRecord::Migration
  def up
    remove_column :employees, :company_id
    add_column :employees, :office_id, :integer
    add_column :offices, :latitude, :float
    add_column :offices, :longitude, :float
  end

  def down
  end
end
