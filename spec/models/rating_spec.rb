require 'rails_helper'

RSpec.describe Rating, type: :model do
    describe 'validations' do
        context "atmosphere_rating validations" do
            it { should validate_presence_of(:atmosphere_rating) }
            it { should validate_numericality_of(:atmosphere_rating).only_integer }
            it { should validate_inclusion_of(:atmosphere_rating).in_range(1..6) }
        end
        context "availability_rating validations" do
            it { should validate_presence_of(:availability_rating) }
            it { should validate_numericality_of(:availability_rating).only_integer }
            it { should validate_inclusion_of(:availability_rating).in_range(1..6) }
        end

        context "quality_rating validations" do
            it { should validate_presence_of(:quality_rating) }
            it { should validate_numericality_of(:quality_rating).only_integer }
            it { should validate_inclusion_of(:quality_rating).in_range(1..6) }
        end

        context "service_rating validations" do
            it { should validate_presence_of(:service_rating) }
            it { should validate_numericality_of(:service_rating).only_integer }
            it { should validate_inclusion_of(:service_rating).in_range(1..6) }
        end
        context "uniqueness_rating validations" do
            it { should validate_presence_of(:uniqueness_rating) }
            it { should validate_numericality_of(:uniqueness_rating).only_integer }
            it { should validate_inclusion_of(:uniqueness_rating).in_range(1..6) }
        end
        context "value_rating validations" do
            it { should validate_presence_of(:value_rating) }
            it { should validate_numericality_of(:value_rating).only_integer }
            it { should validate_inclusion_of(:value_rating).in_range(1..6) }
        end
    end

    describe "associations" do
        it { should belong_to(:review) }
    end
end
