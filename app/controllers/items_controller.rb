class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:prodcut, :text, :category_id, :status_id, :price, :prefecture_id, :shipping_source_id, :delivery_day_id, :image).merge(user_id: current_user.id)
  end
end