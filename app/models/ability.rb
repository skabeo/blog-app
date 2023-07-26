class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, public: true

    return unless user.present?

    can(:read, Post, user:)
    can :destroy, Post.where(author_id: user.id)

    return unless user.role == 'admin'

    can :destroy, Post
  end
end
