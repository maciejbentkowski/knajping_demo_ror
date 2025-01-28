# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionAbility do
    subject(:question) { described_class.new(user) }

    shared_examples "can read other users questions" do
        it { is_expected.to be_able_to(:read, other_user_question) }
      end

    let(:user) { nil }
    let(:other_user) { create(:user) }
    let(:owner_user) { create(:owner) }
    let(:reviewer_user) { create(:user) }
    let(:first_question) { create(:question, user: owner_user) }
    let(:second_question) { create(:question, user: reviewer_user) }
    let(:other_user_question) { create(:question, user: other_user) }

    context 'when user is not logged in' do
        include_examples "can read other users questions"

        it { is_expected.not_to be_able_to(:create, Question) }
    end

    context 'when user is a regular reviewer' do
        let(:user) { create(:user) }
        let(:own_question) { create(:question, user: user) }

        include_examples "can read other users questions"

        context 'can create comment' do
            it { is_expected.to be_able_to(:create, Question) }
        end

        context 'can manage his comments' do
          it { is_expected.to be_able_to(:edit, own_question) }
          it { is_expected.to be_able_to(:update, own_question) }
          it { is_expected.to be_able_to(:destroy, own_question) }
        end

        context 'cannot manage other users comments' do
            it { is_expected.not_to be_able_to(:edit, other_user_question) }
            it { is_expected.not_to be_able_to(:update, other_user_question) }
            it { is_expected.not_to be_able_to(:destroy, other_user_question) }
        end
    end

    context 'when user is a owner' do
        let (:user) { create(:owner) }
        let(:own_question) { create(:question, user: user) }

        include_examples "can read other users questions"

        context 'can create comment' do
            it { is_expected.to be_able_to(:create, Question) }
        end

        context 'can manage his comments' do
          it { is_expected.to be_able_to(:edit, own_question) }
          it { is_expected.to be_able_to(:update, own_question) }
          it { is_expected.to be_able_to(:destroy, own_question) }
        end

        context 'cannot manage other users comments' do
            it { is_expected.not_to be_able_to(:edit, other_user_question) }
            it { is_expected.not_to be_able_to(:update, other_user_question) }
            it { is_expected.not_to be_able_to(:destroy, other_user_question) }
        end
    end

  context 'when user is a moderator' do
    let(:user) { create(:moderator) }
    let(:own_question) { create(:question, user: user) }

    include_examples "can read other users questions"

    context 'can create and manage any review' do
      it { is_expected.to be_able_to(:create, Question) }
      it { is_expected.to be_able_to(:edit, own_question) }
      it { is_expected.to be_able_to(:update, own_question) }
      it { is_expected.to be_able_to(:destroy, own_question) }
      it { is_expected.to be_able_to(:edit, first_question) }
      it { is_expected.to be_able_to(:update, first_question) }
      it { is_expected.to be_able_to(:destroy, first_question) }
      it { is_expected.to be_able_to(:edit, second_question) }
      it { is_expected.to be_able_to(:update, second_question) }
      it { is_expected.to be_able_to(:destroy, second_question) }
    end
  end

  context 'when user is an admin' do
    let(:user) { create(:admin) }
    let(:own_question) { create(:question, user: user) }

    include_examples "can read other users questions"

    context 'can create and manage any review' do
        it { is_expected.to be_able_to(:create, Question) }
        it { is_expected.to be_able_to(:edit, own_question) }
        it { is_expected.to be_able_to(:update, own_question) }
        it { is_expected.to be_able_to(:destroy, own_question) }
        it { is_expected.to be_able_to(:edit, first_question) }
        it { is_expected.to be_able_to(:update, first_question) }
        it { is_expected.to be_able_to(:destroy, first_question) }
        it { is_expected.to be_able_to(:edit, second_question) }
        it { is_expected.to be_able_to(:update, second_question) }
        it { is_expected.to be_able_to(:destroy, second_question) }
      end
  end
end
