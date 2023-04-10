require 'rails_helper'

RSpec.describe 'Customer Show Page' do
  before(:each) do
    @customer_1 = Customer.create!(name: "John Doe")
    @customer_2 = Customer.create!(name: "Elvis")
    @customer_3 = Customer.create!(name: "John Wick")

    @supermarket_1 = Supermarket.create!(name: "King Soopers", location: "Westminster, CO")

    @item_1 = Item.create!(name: "Banana", price: 1, supermarket_id: @supermarket_1.id )
    @item_2 = Item.create!(name: "Apple", price: 2, supermarket_id: @supermarket_1.id )
    @item_3 = Item.create!(name: "Avocado", price: 3, supermarket_id: @supermarket_1.id )

    CustomerItem.create!(customer_id: @customer_1, item_id: item_1)
    CustomerItem.create!(customer_id: @customer_1, item_id: item_2)
    CustomerItem.create!(customer_id: @customer_1, item_id: item_3)
    CustomerItem.create!(customer_id: @customer_2, item_id: item_1)
    CustomerItem.create!(customer_id: @customer_2, item_id: item_2)
    CustomerItem.create!(customer_id: @customer_3, item_id: item_3)
  end

  describe "User Story 1" do
    it "customer show page exists" do
      visit "/customers/#{@customer_1.id}"
    end
  end
end

# Story 1

# As a visitor, 
# When I visit a customer show page,
# I see the customer's name,
# And I see its a list of its items
# including the item's name, price, and the name of the supermarket that 