class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :sold_out, only: [:index]
  
  def index 
    @item = Item.find(params[:item_id])
    @order_buyer = OrderBuyer.new
    if current_user.id == @item.user_id
      redirect_to root_path
    end  
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

    def sold_out
      if Order.exists?(item_id: params[:item_id])
          redirect_to root_path
       end
    end

end    
