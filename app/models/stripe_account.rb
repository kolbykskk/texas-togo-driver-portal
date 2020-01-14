class StripeAccount < ApplicationRecord
  validates :first_name,
  presence: true, length: { minimum: 1, maximum: 40 }

  validates :last_name,
  presence: true, length: { minimum: 1, maximum: 40 }

  validates :dob_month,
  presence: true

  validates :dob_day,
  presence: true

  validates :dob_year,
  presence: true

  validates :account_type,
  presence: true, inclusion: { in: %w(individual company), message: "%{value} is not a valid account type"}

  validates :tos,
  inclusion: { in: [ true ], message: ": You must agree to the terms of service" }
end
