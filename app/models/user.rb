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

  after_commit :initiate_background_check, :on => :create

  def initiate_background_check
    BackgroundCheckWorker.perform_async(id)
  end

  def phone_number=(val)
    write_attribute(:phone_number, val.gsub(/[^\w\s]/, ''))
  end

  def active_for_authentication?
    super and self.is_active?
  end
end
