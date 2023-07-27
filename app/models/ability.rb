class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, public: true
    can :read, Comment, public: true

    return unless user.present?

    can(:read, Post, user:)
    can :destroy, Post.where(author_id: user.id)

    can(:read, Comment, user:)
    can :destroy, Comment.where(author_id: user.id)

    return unless user.role == 'admin'

    can(:read, Comment, user:)
    # can :destroy, Comment.where(author_id: user.id)
    can :destroy, Post
    can :destroy, Comment
  end
end
