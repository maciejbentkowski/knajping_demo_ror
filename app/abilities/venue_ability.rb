# frozen_string_literal: true

class VenueAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Venue, is_active: true

    return unless user.present?
    if user.admin?
      can :manage, Venue
    elsif user.moderator?
      can :manage, Venue
    elsif user.owner?
      can :read, Venue, user: user
      can :manage, Venue, user: user
    end
  end
end
