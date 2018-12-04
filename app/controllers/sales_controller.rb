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
    after_tax(@sale)
    redirect_to sales_done_path
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    redirect_to sales_path
  end

  private

  def sale_params
    params.require(:sale).permit(:cod, :detail, :category, :value, :discount, :tax, :total)
  end

  def find_sale
    @sale = Sale.find(params[:id])
  end

  def after_tax(sale)
    discounted_value = (sale.value - sale.discount)
    if sale.tax == 0
      tax = 19
      taxed_value = (discounted.value *(1+tax))
    else
      tax = 0
      taxed_value = (discounted.value)
    end
    sale.total = discounted_value
    sale.save
  end
end
