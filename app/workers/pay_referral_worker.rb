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
  end
end
