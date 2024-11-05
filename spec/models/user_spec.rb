require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'validations' do
        context "email validations" do
            it { should validate_presence_of(:email) }
            it { should validate_length_of(:email).is_at_most(255) }
            it { should validate_uniqueness_of(:email).case_insensitive }
        end
        context "username validations" do
            it { should validate_presence_of(:username) }
            it { should validate_length_of(:username).is_at_most(50) }
            it { should validate_uniqueness_of(:username) }
        end
    end

    describe "associations" do
        it { should have_many(:venues).dependent(:nullify) }
        it { should have_many(:reviews).dependent(:destroy) }
        it { should have_many(:comments).dependent(:destroy) }
        it { should have_many(:ratings).through(:reviews) }
        it { should have_many(:questions).dependent(:nullify) }
        it { should have_many(:answers).dependent(:nullify) }
    end

    describe '#best_reviewer' do
        let!(:user1) { create(:user, username: 'User1') }
        let!(:user2) { create(:user, username: 'User2') }
        let!(:user3) { create(:user, username: 'User3') }

        before do
          create_list(:review, 3, user: user1)
          create_list(:review, 5, user: user2) # user2 has the most reviews
          create_list(:review, 2, user: user3)
        end

        it 'returns the user with the most reviews' do
          expect(User.best_reviewer).to eq(user2)
        end
      end
end
