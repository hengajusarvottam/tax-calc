class AddMonthlyIncomeToTaxes < ActiveRecord::Migration[7.0]
  def change
    add_column :taxes, :monthly_income, :integer, null: true
  end
end
