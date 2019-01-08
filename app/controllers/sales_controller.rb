class SalesController < ApplicationController
  before_action :find_sale, only: [:show, :edit, :update, :destroy]
  
  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @discount_added = @sale.value - (@sale.value * (@sale.discount / 100))
    
    @sale.tax   = params[:sale][:tax_exempt].to_i.zero? ? 19 : 0
    @sale.total = @sale.value
    @sale.discount = @sale.discount.to_i
    @sale.total = apply_discount @sale.total, @sale.discount
    @sale.total = apply_discount @sale.total, @sale.tax, 1
    
    @sale.save!
    redirect_to action: :done, id: @sale.id
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    redirect_to sales_path
  end

  def done
    @sale = Sale.find(params[:id])
  end  

  private

  def sale_params
    params.require(:sale).permit(:cod, :detail, :category, :value, :discount, :tax)
  end

  def find_sale
    @sale = Sale.find(params[:id])
  end

  def apply_discount(value, discount, tax = 0)
    if discount.zero?
      value
    else
      if tax == 1
        value + (value * ((discount.to_f / 100)))
      else
        value - (value * ((discount.to_f / 100)))
      end
    end
  end

end
