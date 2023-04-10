require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it {should have_many :customer_items}
    it {should have_many(:customers).through(:customer_items)}
  end

  describe '#instance methods' do 
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

    it 'num_of_customers' do
      expect(@item_1.num_of_customers).to eq(2)

      CustomerItem.create!(customer: @customer_3, item: @item_1)

      expect(@item_1.num_of_customers).to eq(3)


      expect(@item_2.num_of_customers).to eq(2)

      CustomerItem.create!(customer: @customer_3, item: @item_2)

      expect(@item_2.num_of_customers).to eq(3)

      
      expect(@item_4.num_of_customers).to eq(0)
    end
  end
end
