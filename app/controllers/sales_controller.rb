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
    @with_discount = @sale.value - (@sale.value * (@sale.discount / 100))
    if @sale.tax == 1
      @total = @with_discount - (@with_discount * (19 / 100))
      @sale.tax = "No"
      @sale.total = @total
    else
      @sale.tax = "Sí"
      @sale.total = @with_discount
    end
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

end
