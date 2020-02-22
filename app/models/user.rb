class User < ApplicationRecord
  has_many :campaigns, :dependent => :destroy
  has_one :stat, :dependent => :destroy
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

  mount_uploader :drivers_license, VerificationUploader
  mount_uploader :insurance_card, VerificationUploader

  after_commit :zapier_webhook, :on => :create, :unless => :admin?


  def phone_number=(val)
    write_attribute(:phone_number, val.gsub(/([-() ])/, ''))
  end

  def zapier_webhook
    json_account = self.as_json
    json_account["drivers_license"] = drivers_license.url
    json_account["insurance_card"] = drivers_license.url
    options = { 
      :body => json_account
    }

    HTTParty.post("https://hooks.zapier.com/hooks/catch/2833985/od099h6/", options)
  end
end