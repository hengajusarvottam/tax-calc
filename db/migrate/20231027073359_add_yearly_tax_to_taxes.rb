class AddYearlyTaxToTaxes < ActiveRecord::Migration[7.0]
  def change
    add_column :taxes, :yearly_tax, :integer, precision: 10, scale: 2, default: 0, null: true
  end
end
