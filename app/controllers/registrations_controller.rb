require 'checkr'

class RegistrationsController < Devise::RegistrationsController

  def create
    super do
      Checkr.api_key = ENV["CHECKR_SECRET"]

      candidate = Checkr::Candidate.create({
        :first_name => sign_up_params[:first_name],
        :last_name => sign_up_params[:last_name],
        :email => sign_up_params[:email],
        :phone => sign_up_params[:phone_number]
      })

      Checkr::Invitation.create({
        :candidate_id => candidate.id,
        :package => "driver_basic"
      })

      resource.update_attributes(candidate_id: candidate.id)
    end
  end

  protected

  def after_sign_up_path_for(resource)
    new_campaign_path
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :drivers_license, :insurance_card)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :current_password, :drivers_license, :insurance_card)
  end
end