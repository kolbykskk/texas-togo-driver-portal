class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    bgc_payment_path
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :drivers_license, :insurance_card, :drivers_license_cache, :insurance_card_cache)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :current_password)
  end
end