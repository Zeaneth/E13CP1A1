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
    @discounted_value = @sale.value - (@sale.value * (@sale.discount/100))
    
    if @sale.tax == 1
      @sale.tax = 19
      @total = @discounted_value - (@discounted_value * (@sale.tax / 100))
      @sale.total = @total
    else
      @sale.tax = 0
      @sale.total = @discounted_value
    end
    @sale.save!
    redirect_to sales_done_path
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
    params.require(:sale).permit(:cod, :detail, :category, :value, :discount, :tax, :total)
  end

  def find_sale
    @sale = Sale.find(params[:id])
  end

end
