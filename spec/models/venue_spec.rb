require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe "validations" do
    let(:venue) { build(:venue) }
    context "name validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    end
    context "user_id Validations" do
      it { should validate_presence_of(:user_id) }
    end
  end


  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:venue_categories) }
    it { should have_many(:categories).through(:venue_categories) }
    it { should have_many(:questions).dependent(:destroy) }
  end


  describe "scopes" do
    before do
      create(:venue, is_active: true)
      create(:venue, is_active: false)
    end
    it "includes only active venues in the active scope" do
      expect(Venue.active.count).to eq(1)
    end

    it "includes only inactive venues in the inactive scope" do
      expect(Venue.inactive.count).to eq(1)
    end
  end

  describe '#avg_rating' do
  let(:venue) { create(:venue) }

    context 'when there are no reviews' do
      it 'returns 0.0' do
        expect(venue.avg_venue_rating).to eq(0.0)
      end
    end
    context 'when there are reviews' do
      before do
        review1 = create(:review, venue: venue)
        review2 = create(:review, venue: venue)

        create(:rating, review: review1, atmosphere_rating: 4, availability_rating: 3, quality_rating: 4, service_rating: 4, uniqueness_rating: 3, value_rating: 4)
        create(:rating, review: review2, atmosphere_rating: 3, availability_rating: 4, quality_rating: 4, service_rating: 3, uniqueness_rating: 4, value_rating: 4)
      end

      it 'returns the correct average rating rounded to two decimals' do
        expect(venue.avg_venue_rating).to eq(3.67)
      end
    end
  end
end
