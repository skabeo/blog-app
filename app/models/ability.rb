class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, public: true
    can :read, Comment, public: true

    return unless user.present?

    can(:read, Post, user:)
    can :destroy, Post, author: user

    can(:read, Comment, user:)
    can :destroy, Comment, author: user

    return unless user.role == 'admin'

    can :manage, :all
  end
end
