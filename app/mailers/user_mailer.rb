class UserMailer < ApplicationMailer
    def invite(emails)
        mail(to: emails, subject: "Invite to Texas ToGo Driver Portal")
    end
end