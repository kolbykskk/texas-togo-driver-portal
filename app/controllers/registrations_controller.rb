class RegistrationsController < Devise::RegistrationsController

  after_action :check_referral, only: :create

  protected

  def after_sign_up_path_for(resource)
    bgc_payment_path
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :drivers_license, :insurance_card, :drivers_license_cache, :insurance_card_cache)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :current_password, :drivers_license, :insurance_card, :drivers_license_cache, :insurance_card_cache)
  end

  def update_resource(resource, params)
    if true_user.admin? && !params["password"]&.present?
      resource.update_without_password(params.except("current_password"))
    else
      super
    end
  end
  
  def check_referral
    if resource.persisted? # user is created successfuly
      if request.env['affiliate.tag'] && affiliate = User.find_by_id(request.env['affiliate.tag'])
        resource.update_attributes(referrer: affiliate)
      end
    end
  end
end