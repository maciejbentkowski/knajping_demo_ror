# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewAbility do
    subject(:review) { described_class.new(user) }

    shared_examples "can read other users reviews" do
        it { is_expected.to be_able_to(:read, first_review) }
        it { is_expected.to be_able_to(:read, second_review) }
      end

    let(:user) { nil }
    let(:first_venue_owner) { create(:owner) }
    let(:second_venue_owner) { create(:owner) }
    let(:first_reviewer) { create(:user) }
    let(:second_reviewer) { create(:user) }
    let(:first_venue) { create(:venue, user: first_venue_owner, is_active: true) }
    let(:second_venue) { create(:venue, user: second_venue_owner, is_active: true) }
    let(:first_review) { create(:review, venue: first_venue, user: first_reviewer) }
    let(:second_review) { create(:review, venue: second_venue, user: second_reviewer) }

    context 'when user is not logged in' do
        include_examples "can read other users reviews"

        it { is_expected.not_to be_able_to(:create, Review) }
    end

    context 'when reviewer is a regular user' do
        let(:user) { create(:user) }
        let(:own_review) { create(:review, venue: first_venue, user: user) }

        include_examples "can read other users reviews"

        context 'can create review' do
            it { is_expected.to be_able_to(:create, Review) }
        end

        context 'can manage his reviews' do
          it { is_expected.to be_able_to(:edit, own_review) }
          it { is_expected.to be_able_to(:update, own_review) }
        end

        context 'cannot manage other users reviews' do
            it { is_expected.not_to be_able_to(:update, first_review) }
            it { is_expected.not_to be_able_to(:update, second_review) }
        end
    end

    context 'when user is a owner' do
        let (:user) { create(:owner) }

        include_examples "can read other users reviews"

        context 'cannot create review' do
            it { is_expected.not_to be_able_to(:create, Review) }
        end

        context 'cannot manage other users reviews' do
          it { is_expected.not_to be_able_to(:update, first_review) }
          it { is_expected.not_to be_able_to(:update, second_review) }
      end
    end

  context 'when user is a moderator' do
    let(:user) { create(:moderator) }
    let(:own_review) { create(:review, venue: first_venue, user: user) }


    context 'can create and manage any review' do
      it { is_expected.to be_able_to(:create, Review) }
      it { is_expected.to be_able_to(:edit, own_review) }
      it { is_expected.to be_able_to(:update, own_review) }
      it { is_expected.to be_able_to(:update, first_review) }
      it { is_expected.to be_able_to(:destroy, first_review) }
      it { is_expected.to be_able_to(:update, second_review) }
      it { is_expected.to be_able_to(:destroy, second_review) }
    end
  end

  context 'when user is an admin' do
    let(:user) { create(:admin) }
    let(:own_review) { create(:review, venue: first_venue, user: user) }



    context 'can create and manage any review' do
      it { is_expected.to be_able_to(:create, Review) }
      it { is_expected.to be_able_to(:edit, own_review) }
      it { is_expected.to be_able_to(:update, own_review) }
      it { is_expected.to be_able_to(:update, first_review) }
      it { is_expected.to be_able_to(:destroy, first_review) }
      it { is_expected.to be_able_to(:update, second_review) }
      it { is_expected.to be_able_to(:destroy, second_review) }
    end
  end
end
