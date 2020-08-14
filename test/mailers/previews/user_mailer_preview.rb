# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def drivers_license_expiring_email
        UserMailer.drivers_license_expiring(User.last, 14)
    end

    def drivers_license_expired_email
        UserMailer.drivers_license_expired(User.last)
    end

    def insurance_card_expiring_email
        UserMailer.insurance_card_expiring(User.last, 14)
    end

    def insurance_card_expired_email
        UserMailer.insurance_card_expired(User.last)
    end
end
