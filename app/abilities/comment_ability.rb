# frozen_string_literal: true

class CommentAbility
  include CanCan::Ability

  def initialize(user)
      can :read, Comment

      return unless user.present?

      if user.admin?
        can :manage, Comment
      elsif user.moderator?
        can :manage, Comment
      else
        can :create, Comment
        can :destroy, Comment, user_id: user.id
      end
    end
end
