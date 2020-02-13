class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  impersonates :user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :is_active?, if: :logged_in? 

  # Pretty generic method to handle exceptions.
  # You'll probably want to do some logging, notifications, etc.
  def handle_error(message = "Sorry, something failed.", view = 'new')
    flash.now[:alert] = message
    render view
  end

  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def is_active?
    unless current_user.is_active?
      unless current_user.bgc_paid
        redirect_to bgc_payment_path
      else
        redirect_to bgc_pending_path
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
