class ReplyPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    my_record?
  end
end
