# frozen_string_literal: true

class CommentAbility
  include CanCan::Ability

  def initialize(user)
      can :read, Comment

      return unless user.present?


      if user.reviewer?
        can :manage, Comment, user_id: user.id
      end

      if user.owner?
        can :manage, Comment, user_id: user.id
      end

      if user.admin? || user.moderator?
        can :manage, Comment
      end
    end
end
