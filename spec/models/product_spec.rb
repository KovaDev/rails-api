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

end
