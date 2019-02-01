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

  private
  def payment_sheet_params
    params.require(:payment_sheet).permit(
        :sheet
      )
  end
end
