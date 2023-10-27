class AddYearlyTaxToTaxes < ActiveRecord::Migration[7.0]
  def change
    add_column :taxes, :yearly_tax, :decimal, precision: 10, scale: 2
  end
end
