# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerAbility do
    subject(:answer) { described_class.new(user) }

    shared_examples "can read other users answers" do
        it { is_expected.to be_able_to(:read, other_user_answer) }
      end

    let(:user) { nil }
    let(:owner_user) { create(:owner) }
    let(:other_user) { create(:user) }
    let(:owner_answer) { create(:answer, user: owner_user) }
    let(:other_user_answer) { create(:answer, user: owner_user) }


    context 'when user is not logged in' do
        include_examples "can read other users answers"

        it { is_expected.not_to be_able_to(:create, Comment) }
    end

    context 'when user is a regular reviewer' do
        let(:user) { create(:user) }
        let(:own_answer) { create(:answer, user: user) }

        include_examples "can read other users answers"

        context 'can create answer' do
            it { is_expected.to be_able_to(:create, Answer) }
        end

        context 'can manage his answers' do
          it { is_expected.to be_able_to(:edit, own_answer) }
          it { is_expected.to be_able_to(:update, own_answer) }
          it { is_expected.to be_able_to(:destroy, own_answer) }
        end

        context 'cannot manage other users answers' do
            it { is_expected.not_to be_able_to(:edit, other_user_answer) }
            it { is_expected.not_to be_able_to(:update, other_user_answer) }
            it { is_expected.not_to be_able_to(:destroy, other_user_answer) }
        end
    end

    context 'when user is a owner' do
        let (:user) { create(:owner) }
        let(:own_answer) { create(:answer, user: user) }

        include_examples "can read other users answers"

        context 'can create answer' do
            it { is_expected.to be_able_to(:create, Answer) }
        end

        context 'can manage his answers' do
          it { is_expected.to be_able_to(:edit, own_answer) }
          it { is_expected.to be_able_to(:update, own_answer) }
          it { is_expected.to be_able_to(:destroy, own_answer) }
        end

        context 'cannot manage other users answers' do
            it { is_expected.not_to be_able_to(:edit, other_user_answer) }
            it { is_expected.not_to be_able_to(:update, other_user_answer) }
            it { is_expected.not_to be_able_to(:destroy, other_user_answer) }
        end
    end

  context 'when user is a moderator' do
    let(:user) { create(:moderator) }
    let(:own_answer) { create(:answer, user: user) }

    include_examples "can read other users answers"

    context 'can create and manage any review' do
      it { is_expected.to be_able_to(:create, Answer) }
      it { is_expected.to be_able_to(:edit, own_answer) }
      it { is_expected.to be_able_to(:update, own_answer) }
      it { is_expected.to be_able_to(:destroy, own_answer) }
      it { is_expected.to be_able_to(:edit, owner_answer) }
      it { is_expected.to be_able_to(:update, owner_answer) }
      it { is_expected.to be_able_to(:destroy, owner_answer) }
      it { is_expected.to be_able_to(:edit, other_user_answer) }
      it { is_expected.to be_able_to(:update, other_user_answer) }
      it { is_expected.to be_able_to(:destroy, other_user_answer) }
    end
  end

  context 'when user is an admin' do
    let(:user) { create(:admin) }
    let(:own_answer) { create(:answer, user: user) }

    include_examples "can read other users answers"

    context 'can create and manage any review' do
      it { is_expected.to be_able_to(:create, Answer) }
      it { is_expected.to be_able_to(:edit, own_answer) }
      it { is_expected.to be_able_to(:update, own_answer) }
      it { is_expected.to be_able_to(:destroy, own_answer) }
      it { is_expected.to be_able_to(:edit, owner_answer) }
      it { is_expected.to be_able_to(:update, owner_answer) }
      it { is_expected.to be_able_to(:destroy, owner_answer) }
      it { is_expected.to be_able_to(:edit, other_user_answer) }
      it { is_expected.to be_able_to(:update, other_user_answer) }
      it { is_expected.to be_able_to(:destroy, other_user_answer) }
    end
  end
end
