class AddYearlyBonusToTaxes < ActiveRecord::Migration[7.0]
  def change
    add_column :taxes, :yearly_bonus, :integer, default: 0, null: true
  end
end
