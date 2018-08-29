module ApplicationHelper
  def current_user?(user)
    current_user && user == current_user
  end
end
