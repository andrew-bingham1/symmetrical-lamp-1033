class CustomerItemController < ApplicationController
  def create
    item = Item.find_by_id("#{params[:item]}")
    customer = Customer.find_by_id("#{params[:customer]}")
    CustomerItem.create!(customer: customer, item: item)
    redirect_to "/customers/#{customer.id}"
  end
end