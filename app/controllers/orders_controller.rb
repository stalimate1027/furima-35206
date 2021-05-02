class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  def index
    @order = Order.new
  end

  def create
    @order = Order.new(buy_recode_params)
    if @order.valid?
      Payjp.api_key = "sk_test_98c62a73631ea6eb6340d23e"
      Payjp::Charge.create(
        amount: @item.price,
        card: buy_recode_params[:token],
        currency: 'jpy'
      )
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
end
