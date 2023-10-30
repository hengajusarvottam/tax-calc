class AddAnnualCitToTaxes < ActiveRecord::Migration[7.0]
  def change
    add_column :taxes, :annual_cit, :integer, default: 0, null: true
  end
end
