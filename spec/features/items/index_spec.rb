require 'rails_helper'

RSpec.describe 'Items Index Page' do
  before(:each) do
    @customer_1 = Customer.create!(name: "John Doe")
    @customer_2 = Customer.create!(name: "Elvis")
    @customer_3 = Customer.create!(name: "John Wick")

    @supermarket_1 = Supermarket.create!(name: "King Soopers", location: "Westminster, CO")

    @item_1 = Item.create!(name: "Banana", price: 1, supermarket: @supermarket_1)
    @item_2 = Item.create!(name: "Apple", price: 2, supermarket: @supermarket_1)
    @item_3 = Item.create!(name: "Avocado", price: 3, supermarket: @supermarket_1)
    @item_4 = Item.create!(name: "Bagels", price: 5, supermarket: @supermarket_1)

    CustomerItem.create!(customer: @customer_1, item: @item_1)
    CustomerItem.create!(customer: @customer_1, item: @item_2)
    CustomerItem.create!(customer: @customer_1, item: @item_3)
    CustomerItem.create!(customer: @customer_2, item: @item_1)
    CustomerItem.create!(customer: @customer_2, item: @item_2)
    CustomerItem.create!(customer: @customer_3, item: @item_3)
  end

  describe "User Story 3" do 
    it 'Item Index Page exists' do
      visit "/items"
    
      expect(current_path).to eq("/items")
    end

    it "Then I see a list of all items including the item's name, price, and the name of the supermarket that it belongs to" do
      visit "/items"

      within("#Banana") do
        expect(page).to have_content("Item Name: Banana")
        expect(page).to have_content("Price: 1 dollar(s)")
        expect(page).to have_content("Supermarket: King Soopers")
      end

      within("#Apple") do
        expect(page).to have_content("Item Name: Apple")
        expect(page).to have_content("Price: 2 dollar(s)")
        expect(page).to have_content("Supermarket: King Soopers")
      end

      within("#Avocado") do
        expect(page).to have_content("Item Name: Avocado")
        expect(page).to have_content("Price: 3 dollar(s)")
        expect(page).to have_content("Supermarket: King Soopers")
      end

      within("#Bagels") do
        expect(page).to have_content("Item Name: Bagels")
        expect(page).to have_content("Price: 5 dollar(s)")
        expect(page).to have_content("Supermarket: King Soopers")
      end
    end

    it 'and the count of customers that bought that item.' do
      visit "/items"

      within("#Banana") do
        expect(page).to have_content("Number of Customers: 2")
      end

      within("#Apple") do
        expect(page).to have_content("Number of Customers: 2")
      end

      within("#Avocado") do
        expect(page).to have_content("Number of Customers: 2")
      end

      within("#Bagels") do
        expect(page).to have_content("Number of Customers: 0")
      end
    end
  end

end



# 