class AddCompanyIdToOffice < ActiveRecord::Migration
  def change
    add_column :offices, :company_id, :serial
  end
end
