class TweetPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    create?
  end

  def edit?
    update?
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

  private

    def my_record?
      record.user == user
    end
end
