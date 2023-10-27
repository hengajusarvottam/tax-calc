class AddAssessmentTypeToTaxes < ActiveRecord::Migration[7.0]
  def change
    add_column :taxes, :assessment_type, :string
  end
end
