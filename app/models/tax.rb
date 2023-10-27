# app/models/tax.rb

class Tax < ApplicationRecord
    validates :monthly_income, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :assessment_type, presence: true
  
    # Other model attributes and associations go here
  end
  