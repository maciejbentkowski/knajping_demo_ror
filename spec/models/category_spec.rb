require 'rails_helper'

RSpec.describe Category, type: :model do
    describe 'validations' do
        it { should validate_presence_of(:name) }
    end

    describe "associations" do
        it { should have_many(:venue_categories) }
        it { should have_many(:venues).through(:venue_categories) }
    end
end
