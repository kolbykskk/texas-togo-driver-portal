class RetryDisbursmentsWorker
  include Sidekiq::Worker

  def perform(payment_sheet_id)
    payment_sheet = PaymentSheet.find(payment_sheet_id)
    not_found_disbursments = payment_sheet.disbursments.where(not_found: true)

    not_found_disbursments.each do |item|
      user = User.find_by(phone_number: item.driver_phone)
      next if user.nil? || user.try(:stripe_account).nil?

      amount = item.amount
  
      payment_sheet.total_paid += amount
      stat = Stat.find_by(user_id: user.id)
      stat.days_worked += 1
      stat.deliveries += item.deliveries_made
      stat.save
      
      account_id = user.stripe_account 
      transfer = Stripe::Transfer.create(
        {
          amount: amount,
          currency: "usd",
          destination: account_id
        }
      )
      item.not_found = false
      item.save
      payment_sheet.not_found -= 1
      payment_sheet.number_of_drivers += 1 
      payment_sheet.save
    end
  end
end
