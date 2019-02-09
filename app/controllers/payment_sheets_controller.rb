class PaymentSheetsController < ApplicationController
  def create
    @payment_sheet = PaymentSheet.new(payment_sheet_params)
    if @payment_sheet.save
        ProcessPaymentSheetWorker.perform_async
        flash[:success] = "Payment disbursment process successfully started in the background."
        redirect_to dashboard_path
    else
      flash[:error] = "There was an error."
      redirect_to dashboard_path
    end
  end

  def disbursments
    @payment_sheet = PaymentSheet.find(params[:id])
    authorize @payment_sheet
    @disbursments = Disbursment.where(payment_sheet_id: params[:id])
    @driver_count = @disbursments.where(not_found: false).count
    @total_paid = @disbursments.where(not_found: false).sum(:amount)
    @deliveries_made = @disbursments.where(not_found: false).sum(:deliveries_made)
  end

  def retry
    RetryDisbursmentsWorker.perform_async(params[:payment_sheet_id])
    flash[:success] = "Retry started in the background."
    redirect_back(fallback_location: root_path)
  end

  private
  def payment_sheet_params
    params.require(:payment_sheet).permit(
        :sheet
      )
  end
end
