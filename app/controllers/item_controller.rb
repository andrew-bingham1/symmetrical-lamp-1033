class ItemController < ApplicationController
  def index
    @items = Item.all
  end
end