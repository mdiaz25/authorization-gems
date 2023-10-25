# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.admin?
      admin_permissions(user)
    else
      user_permissions(user)
    end
  end

  def admin_permissions(user)
    can :manage, Post
    cannot :delete, Post
  end

  def user_permissions(user)
    can :read, Post, published: true
    can :read, Post, published: false, user_id: user.id
    can [:update, :destroy], Post, user_id: user.id
    can :create, Post, user_id: user.id
  end
end
