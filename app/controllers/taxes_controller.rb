class TaxesController < ApplicationController
    def new
      @tax = Tax.new
    end
  
    def create
      @tax = Tax.new(tax_params)
      if @tax.save
        redirect_to @tax, notice: 'Tax information was successfully saved.'
      else
        render 'new'
      end
    end
  
    def show
      @tax = Tax.find(params[:id])
      calculate_tax
    end
  
    private
  
    def tax_params
      params.require(:tax).permit(:income, :monthly_income, :assessment_type)
    end
  
    def calculate_tax
        # Initialize @tax_yearly with a default value
        @tax_yearly = 0
      
        # Retrieve the monthly income and assessment type
        monthly_income = @tax.monthly_income
        assessment_type = @tax.assessment_type
        yearly_income = monthly_income * 12
      
        if assessment_type == 'Single'
          if yearly_income <= 500000
            @tax_yearly = (yearly_income) * 0.01
          elsif yearly_income <= 700000
            @tax_yearly = 5000 + ((yearly_income - 500000) * 0.1)
          elsif yearly_income <= 1000000
            @tax_yearly = 20000 + ((yearly_income - 700000) * 0.2)
          elsif yearly_income <= 2000000
            @tax_yearly = 60000 + ((yearly_income - 1000000) * 0.3)
          else
            @tax_yearly = 180000 + ((yearly_income - 2000000) * 0.36)
          end
        elsif assessment_type == 'Couple'
          if yearly_income <= 600000
            @tax_yearly = (yearly_income) * 0.01
          elsif yearly_income <= 800000
            @tax_yearly = 6000 + ((yearly_income - 600000) * 0.1)
          elsif yearly_income <= 1100000
            @tax_yearly = 16000 + ((yearly_income - 800000) * 0.2)
          elsif yearly_income <= 2000000
            @tax_yearly = 32000 + ((yearly_income - 1100000) * 0.3)
          else
            @tax_yearly = 92000 + ((yearly_income - 2000000) * 0.36)
          end
        end
      
        # Calculate the monthly tax based on the yearly tax
        @tax_monthly = @tax_yearly / 12
        binding.pry
    end     
end
  