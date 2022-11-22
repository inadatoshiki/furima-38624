class OrdersController < ApplicationController
  
  def index
    @order_buyer = OrderBuyer.new
  end
  
  def create
    @order_buyer = OrderBuyer.new(order_params)
    if @order_buyer.valid?
      @order_buyer.save
      redirect_to root_path
    else
      render :index
    end

    private

    def order_params
      params.require(:order_buyer).permit(:post_code, :prefecture_id, :city, :address, :building, :phone).merge(user_id: current_user.id)
    end

end