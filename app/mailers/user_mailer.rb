class UserMailer < ApplicationMailer
    def invite(emails)
        mail(to: emails, subject: "Invite to Texas ToGo Driver Portal")
    end

    def drivers_license_expiring(user, days)
        @user = user
        @days = days
        mail(to: @user.email, subject: "Your Driver's License is Expiring")
    end

    def drivers_license_expired(user)
        @user = user
        mail(to: @user.email, subject: "Your Driver's License Expired")
    end

    def insurance_card_expiring(user, days)
        @user = user
        @days = days
        mail(to: @user.email, subject: "Your Insurance Card is Expiring")
    end

    def insurance_card_expired(user)
        @user = user
        mail(to: @user.email, subject: "Your Insurance Card Expired")
    end

    def background_check_expiring(user, days)
        @user = user
        @days = days
        mail(to: @user.email, subject: "Your Background Check is Expiring")
    end
end