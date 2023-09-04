# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
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
    can :read, Post, :all
    can :update, Post, user_id: user.id
  end
end
