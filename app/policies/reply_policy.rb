class ReplyPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    my_record?
  end

  def update?
    my_record?
  end

  def destroy?
    my_record?
  end
end
