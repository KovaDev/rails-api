require 'rails_helper'

RSpec.describe User, type: :model do
  
	before { @user = FactoryGirl.build(:user) }

	subject { @user }

	it { expect(subject).to respond_to(:email) }
	it { expect(subject).to respond_to(:password) }
	it { expect(subject).to respond_to(:password_confirmation) }

	it { expect(subject).to validate_presence_of(:email) }
	it { expect(subject).to validate_uniqueness_of(:email) }
	it { expect(subject).to validate_confirmation_of(:password) }
	it { expect(subject).to allow_value('example@domain.com').for(:email) }


	it { expect(subject).to be_valid }

end
