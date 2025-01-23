class ReviewAbility
  include CanCan::Ability

  def initialize(user)
    # All users can read reviews
    can :read, Review

    return unless user.present?

    if user.admin? || user.moderator?
      can :manage, Review
    elsif user.reviewer?
      # Regular users can create reviews (venue ownership check is in controller)
      can :create, Review

      # Users can edit their own reviews
      can [ :edit, :update ], Review do |review|
        review.user_id.to_i == user.id
      end
    elsif user.owner?
      cannot [ :new, :create, :edit, :update ], Review
    end
  end
end
