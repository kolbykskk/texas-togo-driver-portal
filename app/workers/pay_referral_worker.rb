class PayReferralWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(first_stripe_account, second_stripe_account)
    Stripe::Transfer.create(
        {
          amount: "5000",
          currency: "usd",
          destination: first_stripe_account
        }
      )

      Stripe::Transfer.create(
        {
          amount: "5000",
          currency: "usd",
          destination: second_stripe_account
        }
      )

      User.find_by(stripe_account: first_stripe_account).update_attributes(refer_paid: true)
  end
end
