require 'rails_helper'

RSpec.describe User, type: :model do
  
	before { @user = FactoryGirl.build(:user) }

	subject { @user }

	it { expect(subject).to respond_to(:email) }
	it { expect(subject).to respond_to(:password) }
	it { expect(subject).to respond_to(:password_confirmation) }
	it { expect(subject).to respond_to(:auth_token) }

	it { expect(subject).to validate_presence_of(:email) }
	it { expect(subject).to validate_uniqueness_of(:email) }
	it { expect(subject).to validate_confirmation_of(:password) }
	it { expect(subject).to allow_value('example@domain.com').for(:email) }
	it { expect(subject).to validate_uniqueness_of(:auth_token) }

	it { expect(subject).to be_valid }

	describe "#generate_authentication_token!" do
		it "generates a unique token" do
			Devise.stub(:friendly_token).and_return("auniquetoken123")
			@user.generate_authentication_token!
			expect(@user.auth_token).to eql "auniquetoken123"
		end

		it "generates another token when one has been already taken" do
			existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
			@user.generate_authentication_token!
			expect(@user.auth_token).not_to eql existing_user.auth_token
		end		
	end	

end
