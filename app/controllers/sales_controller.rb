class SalesController < ApplicationController
  before_action :find_sale, only: [:show, :edit, :update, :destroy]
  
  def index
    @sale = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.discount = (@sale.value - @sale.discount)
    
    @sale.save
    redirect_to sales_path
  end


  private

  def sale_params
    params.require(:sale).permit(:cod, :detail, :category, :value, :discount, :tax, :total)
  end

  def find_sale
    @sale = Sale.find(params[:id])
  end
end
