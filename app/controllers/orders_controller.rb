class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :chack_user

  def index
    @order = Order.new
  end

  def create
    @order = Order.new(buy_recode_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buy_recode_params
    params.require(:order).permit(:postal_code, :prefecture_id, :town, :address, :building, :phone_number).merge(user_id:current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: buy_recode_params[:token],
        currency: 'jpy'
      )
  end

  def chack_user
    if current_user.id == @item.user_id || @item.buy_record
      redirect_to root_path
    end
  end
end