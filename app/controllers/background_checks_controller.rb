class BackgroundChecksController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    skip_before_action :is_active?

    before_action :go_to_dashboard    
    before_action :go_to_payment, only: :pending
    before_action :go_to_pending, only: :payment

    def payment
  
    end
  
    def pending
  
    end
  
    def charge
      Stripe.api_key = 'sk_test_dzEB4SxsyceQgUDSWdqMmIV7'
  
      token = params[:stripeToken]
      
      begin
        charge = Stripe::Charge.create({
          amount: 1500,
          currency: 'usd',
          source: token
        })
  
        BackgroundCheckWorker.perform_async(current_user.id)
        current_user.update_attributes(bgc_paid: true)
        redirect_to bgc_pending_path
        
      rescue Stripe::StripeError => e
        flash[:error] = e.message
        redirect_to users_bgc_payment_path
      rescue => e
        flash[:error] = e.message
        redirect_to users_bgc_payment_path
      end
    end

    private
    def go_to_dashboard
        redirect_to dashboard_path if current_user.is_active?
    end

    def go_to_payment
        redirect_to bgc_payment_path unless current_user.bgc_paid
    end

    def go_to_pending
        redirect_to bgc_pending_path if current_user.bgc_paid
    end
end
