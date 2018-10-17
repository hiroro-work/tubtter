class ApplicationController < ActionController::Base
  include Pundit

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name icon_x icon_y icon_width icon_height icon icon_cache])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name icon_x icon_y icon_width icon_height icon icon_cache remove_icon])
    end

    # def user_not_authorized(exception)
    #   flash[:alert] = '権限がありません。'
    #   redirect_to(request.referrer || root_path)
    # end
end
