# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentAbility do
    subject(:comment) { described_class.new(user) }

    shared_examples "can read other users comments" do
        it { is_expected.to be_able_to(:read, other_user_comment) }
      end

    let(:user) { nil }
    let(:reviewer_user) { create(:user) }
    let(:owner_user) { create(:owner) }
    let(:other_user) { create(:user)}
    let(:first_review) { create(:review, user: reviewer_user) }
    let(:second_review) { create(:review, user: reviewer_user) }
    let(:first_comment) { create(:comment, review: first_review, user: owner_user) }
    let(:second_comment) { create(:comment, review: second_review, user: reviewer_user) }
    let(:other_user_comment) {create(:comment, review: first_review, user: other_user)}


    context 'when user is not logged in' do
        include_examples "can read other users comments"

        it { is_expected.not_to be_able_to(:create, Comment) }
    end

    context 'when user is a regular reviewer' do
        let(:user) { create(:user) }
        let(:own_comment) {create(:comment , review: first_review, user: user)}

        include_examples "can read other users comments"

        context 'can create comment' do
            it { is_expected.to be_able_to(:create, Comment) }
        end

        context 'can manage his comments' do
          it { is_expected.to be_able_to(:edit, own_comment) }
          it { is_expected.to be_able_to(:update, own_comment) }
          it { is_expected.to be_able_to(:destroy, own_comment) }
        end

        context 'cannot manage other users comments' do
            it { is_expected.not_to be_able_to(:edit, other_user_comment) }
            it { is_expected.not_to be_able_to(:update, other_user_comment) }
            it { is_expected.not_to be_able_to(:destroy, other_user_comment) }
        end
    end

    context 'when user is a owner' do
        let (:user) { create(:owner) }
        let(:own_comment) {create(:comment , review: second_review, user: user)}

        include_examples "can read other users comments"

        context 'can create comment' do
            it { is_expected.to be_able_to(:create, Comment) }
        end

        context 'can manage his comments' do
          it { is_expected.to be_able_to(:edit, own_comment) }
          it { is_expected.to be_able_to(:update, own_comment) }
          it { is_expected.to be_able_to(:destroy, own_comment) }
        end

        context 'cannot manage other users comments' do
            it { is_expected.not_to be_able_to(:edit, other_user_comment) }
            it { is_expected.not_to be_able_to(:update, other_user_comment) }
            it { is_expected.not_to be_able_to(:destroy, other_user_comment) }
        end
    end

  context 'when user is a moderator' do
    let(:user) { create(:moderator) }
    let(:own_comment) {create(:comment , review: second_review, user: user)}

    include_examples "can read other users comments"

    context 'can create and manage any review' do
      it { is_expected.to be_able_to(:create, Comment) }
      it { is_expected.to be_able_to(:edit, own_comment) }
      it { is_expected.to be_able_to(:update, own_comment) }
      it { is_expected.to be_able_to(:destroy, own_comment)}
      it { is_expected.to be_able_to(:edit, first_comment) }
      it { is_expected.to be_able_to(:update, first_comment) }
      it { is_expected.to be_able_to(:destroy, first_comment) }
      it { is_expected.to be_able_to(:edit, second_comment) }
      it { is_expected.to be_able_to(:update, second_comment) }
      it { is_expected.to be_able_to(:destroy, second_comment) }
    end
  end

  context 'when user is an admin' do
    let(:user) { create(:admin) }
    let(:own_comment) {create(:comment , review: second_review, user: user)}

    include_examples "can read other users comments"

    context 'can create and manage any review' do
        it { is_expected.to be_able_to(:create, Comment) }
        it { is_expected.to be_able_to(:edit, own_comment) }
        it { is_expected.to be_able_to(:update, own_comment) }
        it { is_expected.to be_able_to(:destroy, own_comment)}
        it { is_expected.to be_able_to(:edit, first_comment) }
        it { is_expected.to be_able_to(:update, first_comment) }
        it { is_expected.to be_able_to(:destroy, first_comment) }
        it { is_expected.to be_able_to(:edit, second_comment) }
        it { is_expected.to be_able_to(:update, second_comment) }
        it { is_expected.to be_able_to(:destroy, second_comment) }
      end
  end
end
