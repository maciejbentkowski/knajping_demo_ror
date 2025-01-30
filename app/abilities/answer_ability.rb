# frozen_string_literal: true

class AnswerAbility
    include CanCan::Ability
  
    def initialize(user)
        can :read, Answer
  
        return unless user.present?
  
  
        if user.reviewer?
          can :manage, Answer, user_id: user.id
        end
  
        if user.owner?
          can :manage, Answer, user_id: user.id
        end
  
        if user.admin? || user.moderator?
          can :manage, Answer
        end
      end
  end
  