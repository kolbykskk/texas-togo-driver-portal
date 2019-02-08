class PaymentSheet < ApplicationRecord
    mount_uploader :sheet, SheetUploader
    has_many :disbursments
    before_save :default_values

    def default_values
        self.total_paid ||= 0
        self.number_of_drivers ||= 0
        self.not_found ||= 0
    end
end
