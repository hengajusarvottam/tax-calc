class AddYearlyBonusToTaxes < ActiveRecord::Migration[7.0]
  def change
    add_column :taxes, :yearly_bonus, :float
  end
end
