class RegistrationsController < Devise::RegistrationsController

  after_action :check_referral, only: :create

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      # bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def set_flash_message_for_update(resource, prev_unconfirmed_email)
    return unless is_flashing_format?

    flash_key = if update_needs_confirmation?(resource, prev_unconfirmed_email)
                  :update_needs_confirmation
                elsif sign_in_after_change_password?
                  :updated
                else
                  :updated_but_not_signed_in
                end
    set_flash_message :notice, flash_key
  end

  def sign_in_after_change_password?
    return true if account_update_params[:password].blank?

    Devise.sign_in_after_change_password
  end

  protected

  def after_sign_up_path_for(resource)
    bgc_payment_path
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :drivers_license, :insurance_card, :drivers_license_cache, :insurance_card_cache, :location_id)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :current_password, :drivers_license, :insurance_card, :drivers_license_cache, :insurance_card_cache, :drivers_license_expiration_date, :insurance_card_expiration_date, :inactive)
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