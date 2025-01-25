# frozen_string_literal: true

class ReviewAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Review

    return unless user.present?

    if user.reviewer?
      can :create, Review
      can [ :edit, :update ], Review do |review|
        review.user_id.to_i == user.id
      end
    end

    if user.admin? || user.moderator?
      can :manage, Review
    end
  end
end
