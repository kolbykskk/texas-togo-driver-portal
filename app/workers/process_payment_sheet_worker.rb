class ProcessPaymentSheetWorker
  include Sidekiq::Worker
  require 'csv'    

  def perform(*args)
    csv_file = PaymentSheet.last.sheet.path
    CSV.foreach(csv_file).map { |row| 
      amount = row[9]

      charge = Stripe::Charge.create({
        source: charge_params[:stripeToken],
        amount: amount,
        currency: "usd",
        # application_fee: amount/10, # Take a 10% application fee for the platform
        destination: account_id
        }
      )
    }
  end
end
