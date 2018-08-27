module UsersHelper
  def current_user?
    @user && @current_user && @user === @current_user
  end
end
