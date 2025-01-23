# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VenueAbility do
  subject(:ability) { described_class.new(user) }

  shared_examples "can read only active venues" do
    it { is_expected.to be_able_to(:read, active_venue) }
    it { is_expected.not_to be_able_to(:read, inactive_venue) }
  end

  shared_examples "can read all venues regardless of status" do
    it { is_expected.to be_able_to(:read, active_venue) }
    it { is_expected.to be_able_to(:read, inactive_venue) }
  end

  let(:user) { nil }
  let(:venue_owner) { create(:owner) }
  let(:active_venue) { create(:venue, user: venue_owner, is_active: true) }
  let(:inactive_venue) { create(:venue, user: venue_owner, is_active: false) }
  let(:others_active_venue) { create(:venue, user: create(:owner), is_active: true) }
  let(:others_inactive_venue) { create(:venue, user: create(:owner), is_active: false) }

  context 'when user is not logged in' do
    include_examples "can read only active venues"

    it { is_expected.not_to be_able_to(:create, Venue) }
    it { is_expected.not_to be_able_to(:update, active_venue) }
    it { is_expected.not_to be_able_to(:destroy, active_venue) }
    it { is_expected.not_to be_able_to(:update, inactive_venue) }
    it { is_expected.not_to be_able_to(:destroy, inactive_venue) }
  end

  context 'when user is a regular user' do
    let(:user) { create(:user) }

    include_examples "can read only active venues"

    context 'cannot create venue' do
      it { is_expected.not_to be_able_to(:create, Venue) }
    end

    context 'cannot manage others venues' do
      it { is_expected.not_to be_able_to(:update, others_active_venue) }
      it { is_expected.not_to be_able_to(:destroy, others_active_venue) }
      it { is_expected.not_to be_able_to(:update, others_inactive_venue) }
      it { is_expected.not_to be_able_to(:destroy, others_inactive_venue) }
    end
  end

  context 'when user is a owner' do
    let (:user) { create(:owner) }
    let(:own_active_venue) { create(:venue, user: user, is_active: true) }
    let(:own_inactive_venue) { create(:venue, user: user, is_active: false) }

    context 'can read all own venues regardless of status' do
      it { is_expected.to be_able_to(:read, own_active_venue) }
      it { is_expected.to be_able_to(:read, own_inactive_venue) }
    end

    context 'can create and manage his own venues' do
      it { is_expected.to be_able_to(:create, Venue) }
      it { is_expected.to be_able_to(:update, own_active_venue) }
      it { is_expected.to be_able_to(:destroy, own_active_venue) }
      it { is_expected.to be_able_to(:update, own_inactive_venue) }
      it { is_expected.to be_able_to(:destroy, own_inactive_venue) }
    end

    context 'cannot manage others venues' do
      it { is_expected.not_to be_able_to(:update, others_active_venue) }
      it { is_expected.not_to be_able_to(:destroy, others_active_venue) }
      it { is_expected.not_to be_able_to(:update, others_inactive_venue) }
      it { is_expected.not_to be_able_to(:destroy, others_inactive_venue) }
    end
  end

  context 'when user is a moderator' do
    let(:user) { create(:moderator) }
    let(:own_venue) { create(:venue, user: user) }

    include_examples "can read all venues regardless of status"

    context 'can create and manage any venue' do
      it { is_expected.to be_able_to(:create, Venue) }
      it { is_expected.to be_able_to(:update, own_venue) }
      it { is_expected.to be_able_to(:destroy, own_venue) }
      it { is_expected.to be_able_to(:update, others_active_venue) }
      it { is_expected.to be_able_to(:update, others_inactive_venue) }
      it { is_expected.to be_able_to(:destroy, others_active_venue) }
      it { is_expected.to be_able_to(:destroy, others_inactive_venue) }
    end
  end

  context 'when user is an admin' do
    let(:user) { create(:admin) }
    let(:own_venue) { create(:venue, user: user) }


    include_examples "can read all venues regardless of status"

    context 'can create and manage any venue' do
      it { is_expected.to be_able_to(:create, Venue) }
      it { is_expected.to be_able_to(:update, own_venue) }
      it { is_expected.to be_able_to(:destroy, own_venue) }
      it { is_expected.to be_able_to(:update, others_active_venue) }
      it { is_expected.to be_able_to(:update, others_inactive_venue) }
      it { is_expected.to be_able_to(:destroy, others_active_venue) }
      it { is_expected.to be_able_to(:destroy, others_inactive_venue) }
    end
  end
end
