require 'rails_helper'

RSpec.describe VenueCategory, type: :model do
    describe "associations" do
        it { should belong_to(:venue) }
        it { should belong_to(:category) }
    end
end
