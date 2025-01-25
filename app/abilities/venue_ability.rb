# frozen_string_literal: true

class VenueAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Venue, is_active: true

    return unless user.present?

    if user.owner?
      can :read, Venue, user: user
      can :manage, Venue, user: user
    end

    if user.admin? || user.moderator?
      can :manage, Venue
    end
  end
end
