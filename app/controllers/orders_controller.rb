class OrdersController < ApplicationController
  def index
    @order = Order.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order = Order.new(buy_recode_params)
    if @order.valid?
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buy_recode_params
    params.require(:order).permit(:postal_code, :prefecture_id, :town, :address, :building, :phone_number).merge(user_id:current_user.id, item_id: params[:item_id])
  end
end
