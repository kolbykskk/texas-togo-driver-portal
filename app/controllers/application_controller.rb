class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  impersonates :user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :block_foreign_hosts

  def block_foreign_hosts
    redirect_to "https://www.txtogo.com/driver_support" unless request.remote_ip.start_with?("68.70.24.114")
  end

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
  
end
