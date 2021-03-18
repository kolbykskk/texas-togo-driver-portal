require 'sidekiq-scheduler'

class BirthdayWebhookWorker
    include Sidekiq::Worker
  
    def perform
        unless ENV["BIRTHDAY_WEBHOOK_URL"].blank?
            users = User.joins('INNER JOIN stripe_accounts on stripe_accounts.acct_id = users.stripe_account').where(inactive: false, stripe_accounts: {dob_month: Date.current.month, dob_day: Date.current.day})
            users.each do |user|
                json_account = user.to_json
                options = { 
                    :body => json_account
                }
            
                HTTParty.post(ENV["BIRTHDAY_WEBHOOK_URL"], options)
            end
        end
    end
end
