require 'rails_helper'

RSpec.describe Review, type: :model do
    describe 'validations' do
        context "title validations" do
            it { should validate_presence_of(:title) }
        end
        context "content validations" do
            it { should validate_presence_of(:content) }
        end

        context "user_id validations" do
            it { should validate_presence_of(:user_id) }
        end

        context "venue_id validations" do
            it { should validate_presence_of(:venue_id) }
        end
    end

    describe "associations" do
        it { should belong_to(:venue) }
        it { should belong_to(:user) }
        it { should have_many(:comments).dependent(:destroy) }
        it { should have_one(:rating).dependent(:destroy) }
        it { should accept_nested_attributes_for(:rating) }
    end
end
