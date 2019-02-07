class ProcessPaymentSheetWorker
  include Sidekiq::Worker
  require 'csv'    

  def perform(*args)
    payment_sheet = PaymentSheet.last
    CSV.foreach(CSV.parse(open(payment_sheet.sheet.url).read).map { |row| 
      user = User.find_by(phone_number: row[1])
      if !user.nil?
        amount = (row[9].to_f * 100).to_i
        commissions = (row[5].to_f * 100).to_i
        tips = (row[6].to_f * 100).to_i
        charges = (row[7].to_f * 100).to_i
        credits = (row[8].to_f * 100).to_i

        payment_sheet.total_paid += amount
        account_id = user.stripe_account 

        next if user.stripe_account.nil?

        stat = Stat.find_by(user_id: user.id)
        stat.days_worked += 1
        stat.deliveries += row[10].to_i
        stat.save

        transfer = Stripe::Transfer.create(
          {
            amount: amount,
            currency: "usd",
            destination: account_id
          }
        )

        Disbursment.create(deliveries_made: row[10].to_i, commissions: commissions, tips: tips, charges: charges, credits: credits, payment_sheet_id: payment_sheet.id, driver_name: row[0], driver_phone: row[1], amount: amount)
        payment_sheet.number_of_drivers += 1 
      end
    }
    payment_sheet.finished = true
    payment_sheet.save
  end
end