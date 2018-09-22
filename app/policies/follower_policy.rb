class FollowerPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    my_record?
  end

  def destroy?
    my_record?
  end
end
