# frozen_string_literal: true

class VenueAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Venue, :all

    return unless user.present?
    can :manage, Venue, user: user
  end
end
