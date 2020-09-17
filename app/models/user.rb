class User < ApplicationRecord
  has_many :campaigns, :dependent => :destroy
  has_one :stat, :dependent => :destroy
  belongs_to :location
  belongs_to :referrer, :class_name => 'User', foreign_key: 'referred_by_id', optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :phone_number
  validates_uniqueness_of :phone_number
  validates_presence_of :drivers_license, :on => :create, :unless => :admin?
  validates_presence_of :insurance_card, :on => :create, :unless => :admin?

  validate :location_is_active, :on => :create

  after_update :zap_webhook_on_inactive, if: Proc.new { inactive_changed? && inactive }

  mount_uploader :drivers_license, VerificationUploader
  mount_uploader :insurance_card, VerificationUploader

  after_commit :zapier_webhook, :on => :create, :unless => :admin?

  def location_is_active
    unless self.location_id && Location.find(self.location_id).active
      errors.add(:location_id, 'must be active')
    end
  end

  def phone_number=(val)
    write_attribute(:phone_number, val.gsub(/([-() ])/, ''))
  end

  def zap_webhook_on_inactive
    unless ENV["USER_INACTIVE_WEBHOOK_URL"].blank?
      puts '^^^^^^^^^^^^^^^^^^^^'
      json_account = self.as_json
      options = { 
        :body => json_account
      }

      HTTParty.post(ENV["USER_INACTIVE_WEBHOOK_URL"], options)
    end
  end

  def zapier_webhook
    unless ENV["NEW_USER_WEBHOOK_URL"].blank?
      json_account = self.as_json
      options = { 
        :body => json_account
      }

      HTTParty.post(ENV["NEW_USER_WEBHOOK_URL"], options)
    end
  end
end