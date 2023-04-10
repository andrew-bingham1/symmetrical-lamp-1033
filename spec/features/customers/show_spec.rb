require 'rails_helper'

RSpec.describe 'Customer Show Page' do
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

  describe "User Story 1" do
    it "customer show page exists" do
      visit "/customers/#{@customer_1.id}"
    end

    it "I see the customer's name" do
      visit "/customers/#{@customer_1.id}"

      expect(page).to have_content(@customer_1.name)
    end

    it "And I see its a list of its items including the item's name, price, and the name of the supermarket that it belongs to." do
      visit "/customers/#{@customer_1.id}"

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
    end
  end

  describe "User Story 2" do
    it "When I visit a customer's show page, Then I see a form to add an item to this customer." do
      visit "/customers/#{@customer_1.id}"

      within("#NewItem") do
        expect(page).to have_field("item")
      end
    end

    it "When I fill in a field with the id of an existing item And I click submit Then I am redirected back to the customer's show page" do
      visit "/customers/#{@customer_1.id}"

      fill_in 'item', with: "#{@item_3.id}"

      click_on 'Submit'

      expect(current_path).to eq("/customers/#{@customer_1.id}")
    end

    it "And I see the item now listed under this customer's items." do 
      visit "/customers/#{@customer_1.id}"

      fill_in 'item', with: "#{@item_4.id}"

      click_on 'Submit'

      within("#Bagels") do
        expect(page).to have_content("Item Name: Bagels")
        expect(page).to have_content("Price: 5 dollar(s)")
        expect(page).to have_content("Supermarket: King Soopers")
      end
    end
  end

end

# Story 2

# When I fill in a field with the id of an existing item,
# And I click submit,
# Then I am redirected back to the customer's show page, 
# And I see the item now listed under this customer's items.
# (You do not have to test for a sad path, for example if the ID submitted is not an existing item)