# frozen_string_literal: true

class QuestionAbility
    include CanCan::Ability
  
    def initialize(user)
        can :read, Question
  
        return unless user.present?
  
  
        if user.reviewer?
          can :manage, Question, user_id: user.id
        end
  
        if user.owner?
          can :manage, Question, user_id: user.id
        end
  
        if user.admin? || user.moderator?
          can :manage, Question
        end
      end
  end
  