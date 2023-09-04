class PostPolicy < ApplicationPolicy
  attr_reader :user, :record
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end

    attr_reader :user, :scope
  end
  def update?
    user.admin? || record.user == user
  end
end
