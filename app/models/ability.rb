# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, :all
    can :update, Post, author_id: user.id
  end
end
