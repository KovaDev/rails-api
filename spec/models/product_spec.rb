require 'rails_helper'

RSpec.describe Product, type: :model do
  
	let(:product) { FactoryGirl.build :product }
	
	subject { product }

	it { expect(subject).to respond_to(:title) }
	it { expect(subject).to respond_to(:price) }
	it { expect(subject).to respond_to(:published) }
	it { expect(subject).to respond_to(:user_id) }

	it { expect(subject).to validate_presence_of(:title) }
	it { expect(subject).to validate_presence_of(:price) }
	it { expect(subject).to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
	it { expect(subject).to validate_presence_of(:user_id) }

	it { expect(subject).not_to be_published } 
	it { expect(subject).to belong_to(:user) }

	describe ".filter_by_title" do
		
		before(:each) do
			@product1 = FactoryGirl.create :product, title: "A plasma TV"
			@product2 = FactoryGirl.create :product, title: "Fastest Laptop"
			@product3 = FactoryGirl.create :product, title: "CD Player"
			@product4 = FactoryGirl.create :product, title: "LCD TV"
		end	

		context "when a 'TV' title pattern is sent" do

			it "returns 2 products matching" do
				expect(Product.filter_by_title("TV").size).to eql 2
			end	

			it "returns the products matching" do
        expect(Product.filter_by_title("TV").sort).to match_array([@product1, @product4])
      end

		end	

	end

	describe ".above_or_equal_to_price" do
    before(:each) do
      @product1 = FactoryGirl.create :product, price: 100
      @product2 = FactoryGirl.create :product, price: 50
      @product3 = FactoryGirl.create :product, price: 150
      @product4 = FactoryGirl.create :product, price: 99
    end

    it "returns the products which are above or equal to the price" do
      expect(Product.above_or_equal_to_price(100).sort).to match_array([@product1, @product3])
    end
  end

  describe ".below_or_equal_to_price" do
    before(:each) do
      @product1 = FactoryGirl.create :product, price: 100
      @product2 = FactoryGirl.create :product, price: 50
      @product3 = FactoryGirl.create :product, price: 150
      @product4 = FactoryGirl.create :product, price: 99
    end

    it "returns the products which are above or equal to the price" do
      expect(Product.below_or_equal_to_price(99).sort).to match_array([@product2, @product4])
    end
  end

  describe ".recent" do
    before(:each) do
      @product1 = FactoryGirl.create :product, price: 100
      @product2 = FactoryGirl.create :product, price: 50
      @product3 = FactoryGirl.create :product, price: 150
      @product4 = FactoryGirl.create :product, price: 99

      #we will touch some products to update them
      @product2.touch
      @product3.touch
    end

    it "returns the most updated records" do
      expect(Product.recent).to match_array([@product3, @product2, @product4, @product1])
    end
  end

end
