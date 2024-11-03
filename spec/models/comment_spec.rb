require 'rails_helper'

RSpec.describe Comment, type: :model do
    describe 'validations' do
        context "content validations" do
            it { should validate_presence_of(:content) }
            it { should validate_length_of(:content).is_at_most(255) }
        end
        context "review_id validations" do
            it { should validate_presence_of(:user_id) }
        end

        context "user_id validations" do
            it { should validate_presence_of(:review_id) }
        end
    end

    describe "associations" do
        it { should belong_to(:review) }
        it { should belong_to(:user) }
    end
end
