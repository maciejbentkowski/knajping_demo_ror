# frozen_string_literal: true

class CommentAbility
  include CanCan::Ability

  def initialize(user)
      return unless user

      can :create, Comment


      can :destroy, Comment, user_id: user.id
    end
end
