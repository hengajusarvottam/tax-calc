class CreateTaxes < ActiveRecord::Migration[7.0]
  def change
    create_table :taxes do |t|
      t.float :income, null: true
      t.timestamps
    end
  end
end
