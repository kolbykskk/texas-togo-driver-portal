class Disbursment < ApplicationRecord
  belongs_to :payment_sheet
  before_save :default_values

  def default_values
      self.not_found ||= false
  end
end
