require 'checkr'

class User < ApplicationRecord
  has_many :campaigns, :dependent => :destroy
  has_one :stat, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :phone_number
  validates_uniqueness_of :phone_number
  validates_presence_of :drivers_license, unless: :admin?
  validates_presence_of :insurance_card, unless: :admin?

  mount_uploader :drivers_license, VerificationUploader
  mount_uploader :insurance_card, VerificationUploader

  after_create :initiate_background_check

  def initiate_background_check
    Checkr.api_key = ENV["CHECKR_SECRET"]

    candidate = Checkr::Candidate.create({
      :first_name => first_name,
      :last_name => last_name,
      :email => email,
      :phone => phone_number
    })

    Checkr::Invitation.create({
      :candidate_id => candidate.id,
      :package => "driver_basic"
    })

    self.update_attributes(candidate_id: candidate.id)
  end

  def phone_number=(val)
    write_attribute(:phone_number, val.gsub(/[^\w\s]/, ''))
  end

  def active_for_authentication?
    super and self.is_active?
  end
end
