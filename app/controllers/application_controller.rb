class ApplicationController < ActionController::Base
  include Pagy::Backend

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  rescue_from CanCan::AccessDenied do |exception|
    if controller_name == "reviews"
      redirect_to venue_path(params[:venue_id]), alert: "You are not authorized to perform this action."
    else
      redirect_to root_path, alert: exception.message
    end
  end
end
