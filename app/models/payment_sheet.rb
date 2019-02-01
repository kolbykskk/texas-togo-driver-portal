class PaymentSheet < ApplicationRecord
    mount_uploader :sheet, SheetUploader
end
