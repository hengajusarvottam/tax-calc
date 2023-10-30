class AddMonthlyIncomeToTaxes < ActiveRecord::Migration[7.0]
  def change
    add_column :taxes, :monthly_income, :integer, default: 0, null: true
  end
end
