class PaymentSheetsController < ApplicationController
  def create
    @payment_sheet = PaymentSheet.new(payment_sheet_params)
    if @payment_sheet.save
        ProcessPaymentSheetWorker.perform_async
        redirect_to dashboard_path
    else
      flash[:error] = "There was an error."
      redirect_to dashboard_path
    end
  end

  def disbursments
    @payment_sheet = PaymentSheet.find_by(params[:id])
    @disbursments = Disbursment.where(payment_sheet_id: params[:id])
    @driver_count = @disbursments.count
    @total_paid = @disbursments.sum(:amount)
    @deliveries_made = @disbursments.sum(:deliveries_made)
  end

  private
  def payment_sheet_params
    params.require(:payment_sheet).permit(
        :sheet
      )
  end
end
