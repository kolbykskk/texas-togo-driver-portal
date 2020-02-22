class Stat < ApplicationRecord
  belongs_to :user
  before_save :default_values

  after_update :reached_10_deliveries, if: :deliveries_changed?

  def reached_10_deliveries
    if user.referrer && deliveries_was < 10 && deliveries >= 10
      PayReferralWorker.perform_async(self.user.stripe_account, self.user.referrer.stripe_account)
    end
  end

  def default_values
      self.deliveries ||= 0
      self.days_worked ||= 0
  end
end
