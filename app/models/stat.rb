class Stat < ApplicationRecord
  belongs_to :user
  before_save :default_values

  after_update :reached_x_deliveries, if: :deliveries_changed?
  after_update :reached_first_delivery, if: :deliveries_changed?
  after_update :reached_one_hundred_deliveries, if: :deliveries_changed?

  def reached_x_deliveries
    if user.referrer && deliveries_was < ENV["REFER_DELIVERIES"].to_i && deliveries >= ENV["REFER_DELIVERIES"].to_i
      PayReferralWorker.perform_async(self.user.stripe_account, self.user.referrer.stripe_account)
      self.user.update_attributes(refer_paid: true)
    end
  end

  def reached_first_delivery
    if deliveries_was == 0 && deliveries > 0
      unless ENV["FIRST_DELIVERY_WEBHOOK_URL"].blank?
        json_account = self.user.to_json
        options = { 
          :body => json_account
        }
    
        HTTParty.post(ENV["FIRST_DELIVERY_WEBHOOK_URL"], options)
      end
    end
  end

  def reached_one_hundred_deliveries
    if deliveries_was < 100 && deliveries >= 100
      unless ENV["100_DELIVERIES_WEBHOOK_URL"].blank?
        json_account = self.user.to_json
        options = { 
          :body => json_account
        }
    
        HTTParty.post(ENV["100_DELIVERIES_WEBHOOK_URL"], options)
      end
    end
  end

  def default_values
      self.deliveries ||= 0
      self.days_worked ||= 0
  end
end
