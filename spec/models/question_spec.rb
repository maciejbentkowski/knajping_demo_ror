require 'rails_helper'

RSpec.describe Question, type: :model do
    describe 'validations' do
        context "question validations" do
            it { should validate_presence_of(:question) }
            it { should validate_length_of(:question).is_at_most(255) }
        end
        context "venue_id validations" do
            it { should validate_presence_of(:venue_id) }
        end

        context "user_id validations" do
            it { should validate_presence_of(:user_id) }
        end
    end

    describe "associations" do
        it { should belong_to(:venue) }
        it { should belong_to(:user) }
        it { should have_many(:answers).dependent(:destroy) }
    end
end
