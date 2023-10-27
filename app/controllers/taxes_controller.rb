# app/controllers/taxes_controller.rb

class TaxesController < ApplicationController
  def new
    @tax = Tax.new
  end

  def create
    @tax = Tax.new(tax_params)
   
    if @tax.save
      calculate_tax(@tax.income, @tax.assessment_type)
      @tax.save  # Save the calculated yearly_tax
  
      # Calculate and save monthly income based on yearly income
      monthly_income = @tax.income / 12
      @tax.update(monthly_income: monthly_income)
  
      redirect_to @tax, notice: 'Tax information was successfully saved and calculated.'
    else
      flash.now[:alert] = 'Tax information could not be saved.'
      render 'new'
    end
  end
  
  def show
    @tax = Tax.find(params[:id])
    calculate_tax(@tax.income, @tax.assessment_type)
  end

  private

  def tax_params
    params.require(:tax).permit(:income, :assessment_type)
  end

  def calculate_tax(yearly_income, assessment_type)
    # Define the tax bands for single and couple
    single_bands = [
      { limit: 500000, rate: 0.01 },
      { limit: 700000, rate: 0.10 },
      { limit: 1000000, rate: 0.20 },
      { limit: 2000000, rate: 0.30 },
      { limit: Float::INFINITY, rate: 0.36 }
    ]

    couple_bands = [
      { limit: 600000, rate: 0.01 },
      { limit: 800000, rate: 0.10 },
      { limit: 1100000, rate: 0.20 },
      { limit: 2000000, rate: 0.30 },
      { limit: Float::INFINITY, rate: 0.36 }
    ]

    bands = assessment_type == 'Single' ? single_bands : couple_bands
    yearly_tax = 0
    previous_limit = 0

    bands.each do |band|
      if yearly_income <= band[:limit]
        yearly_tax += (yearly_income - previous_limit) * band[:rate]
        break
      else
        yearly_tax += (band[:limit] - previous_limit) * band[:rate]
        previous_limit = band[:limit]
      end
    end

    # Save the yearly tax in the @tax object
    @tax.update(yearly_tax: yearly_tax)
  end
end
