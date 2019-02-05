class Stat < ApplicationRecord
  belongs_to :user
  before_save :default_values

  def default_values
      self.deliveries ||= 0
      self.days_worked ||= 0
  end
end
