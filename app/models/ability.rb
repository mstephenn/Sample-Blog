class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Post, Comment]
    return unless user.present?
    can :manage, [Post, Comment], user_id: user.id
  end
end
