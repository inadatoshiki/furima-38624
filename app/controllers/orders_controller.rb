class OrdersController < ApplicationController
  
  def index 
    @item = Item.find(params[:item_id])
    @order_buyer = OrderBuyer.new
  end
  
  def create
    @item = Item.find(params[:item_id])
    @order_buyer = OrderBuyer.new(order_params)
    if @order_buyer.valid?
      pay_item
      @order_buyer.save
      redirect_to root_path
    else
      render :index
    end
  end

    private

    def order_params
      params.require(:order_buyer).permit(:post_code, :prefecture_id, :city, :address, :building, :phone).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
    end

    def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price, 
        card: order_params[:token], 
        currency: 'jpy'    
      )
    end  
end    
