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
        scope.where(published: true)
             .or(scope.where(published: false, user_id: user.id))
      end
    end

    attr_reader :user, :scope
  end
  def update?
    user.admin? || record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end

  def create?
    user.admin? || record.user_id == user.id
  end
end
