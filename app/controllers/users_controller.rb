class UsersController < ApplicationController
    skip_before_action :is_active?, only: :stop_impersonating

    def index
        unless params[:search] && params[:search] != ""
            @users = User.where.not(admin: true).order(:id)
            @active_users = @users.where(inactive: false).paginate(:page => params[:page_2], :per_page => 12)
            @inactive_users = @users.where(inactive: true).paginate(:page => params[:page_3], :per_page => 12)
            @users_pending_expiration = @users.where('drivers_license_expiration_date IS NULL OR insurance_card_expiration_date IS NULL').paginate(:page => params[:page_1], :per_page => 12)
        else
            @users = User.where('admin != (?) and lower(first_name) like (?) or lower(last_name) like (?) or lower(phone_number) like (?)', true, params[:search].downcase, params[:search].downcase, params[:search].downcase).order(:id)
        end
        authorize @users
    end
    
    def impersonate
        user = User.find(params[:id])
        impersonate_user(user)
        redirect_to root_path
    end
    
    def stop_impersonating
        stop_impersonating_user
        redirect_to root_path
    end

    def invite
        unless params[:emails].nil? || params[:emails] == ""
            emails = params[:emails].split("\r\n")
            UserMailer.invite(emails).deliver
            flash[:success] = "Invites sent"
        end
        redirect_back(fallback_location: root_path)
    end

    def sms
        unless params[:message].nil? || params[:message] == "" || params[:locations].nil? || params[:locations].empty?
            TextMessageWorker.perform_async(params[:locations], params[:message])
            flash[:success] = "Messages sent"
        end
        redirect_back(fallback_location: root_path)
    end
end
