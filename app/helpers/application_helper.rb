module ApplicationHelper
  def current_user?(user)
    signed_in? && user == current_user
  end
end
