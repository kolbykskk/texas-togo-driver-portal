require 'sidekiq-scheduler'

class ExpirationDateWorker
    include Sidekiq::Worker
  
    def perform
        users = User.where('drivers_license_expiration_date IN (?)', [Date.current + 14.days, Date.current + 7.days, Date.current + 3.days, Date.current + 2.days, Date.current + 1.day])
        users.each do |user|
            case user.drivers_license_expiration_date
            when Date.current + 14.days
                UserMailer.drivers_license_expiring(user, 14).deliver
                TwilioTextMessenger.new(user.phone_number, 'Your driver\'s license is expiring in 14 days. You will need to update this document to remain an active driver. Go to https://drivers.letsdodelivery.com/users/edit to upload a new driver\'s license.').call
            when Date.current + 7.days
                UserMailer.drivers_license_expiring(user, 7).deliver
                TwilioTextMessenger.new(user.phone_number, 'Your driver\'s license is expiring in 7 days. You will need to update this document to remain an active driver. Go to https://drivers.letsdodelivery.com/users/edit to upload a new driver\'s license.').call
            when Date.current + 3.days
                UserMailer.drivers_license_expiring(user, 3).deliver
                TwilioTextMessenger.new(user.phone_number, 'Your driver\'s license is expiring in 3 days. You will need to update this document to remain an active driver. Go to https://drivers.letsdodelivery.com/users/edit to upload a new driver\'s license.').call
            when Date.current + 2.days
                UserMailer.drivers_license_expiring(user, 2).deliver
                TwilioTextMessenger.new(user.phone_number, 'Your driver\'s license is expiring in 2 days. You will need to update this document to remain an active driver. Go to https://drivers.letsdodelivery.com/users/edit to upload a new driver\'s license.').call
            when Date.current + 1.days
                UserMailer.drivers_license_expiring(user, 1).deliver
                TwilioTextMessenger.new(user.phone_number, 'Your driver\'s license is expiring in 1 day. You will need to update this document to remain an active driver. Go to https://drivers.letsdodelivery.com/users/edit to upload a new driver\'s license.').call
            end
        end

        users = User.where('insurance_card_expiration_date IN (?)', [Date.current + 14.days, Date.current + 7.days, Date.current + 3.days, Date.current + 2.days, Date.current + 1.day])
        users.each do |user|
            case user.insurance_card_expiration_date
            when Date.current + 14.days
                UserMailer.insurance_card_expiring(user, 14).deliver
                TwilioTextMessenger.new(user.phone_number, 'Your insurance card is expiring in 14 days. You will need to update this document to remain an active driver. Go to https://drivers.letsdodelivery.com/users/edit to upload a new insurance card.').call
            when Date.current + 7.days
                UserMailer.insurance_card_expiring(user, 7).deliver
                TwilioTextMessenger.new(user.phone_number, 'Your insurance card is expiring in 7 days. You will need to update this document to remain an active driver. Go to https://drivers.letsdodelivery.com/users/edit to upload a new insurance card.').call
            when Date.current + 3.days
                UserMailer.insurance_card_expiring(user, 3).deliver
                TwilioTextMessenger.new(user.phone_number, 'Your insurance card is expiring in 3 days. You will need to update this document to remain an active driver. Go to https://drivers.letsdodelivery.com/users/edit to upload a new insurance card.').call
            when Date.current + 2.days
                UserMailer.insurance_card_expiring(user, 2).deliver
                TwilioTextMessenger.new(user.phone_number, 'Your insurance card is expiring in 2 days. You will need to update this document to remain an active driver. Go to https://drivers.letsdodelivery.com/users/edit to upload a new insurance card.').call
            when Date.current + 1.days
                UserMailer.insurance_card_expiring(user, 1).deliver
                TwilioTextMessenger.new(user.phone_number, 'Your insurance card is expiring in 1 day. You will need to update this document to remain an active driver. Go to https://drivers.letsdodelivery.com/users/edit to upload a new insurance card.').call
            end
        end

        users = User.where('drivers_license_expiration_date <= ? OR insurance_card_expiration_date <= ?', Date.current, Date.current)
        users.update(inactive: true)

        users = User.where('bgc_completed IN (?)', [(Date.current - 6.months) + 14.days, (Date.current - 6.months) + 7.days, (Date.current - 6.months) + 3.days, (Date.current - 6.months) + 2.days, (Date.current - 6.months) + 1.day])
        users.each do |user|
            case user.bgc_completed
            when (Date.current - 6.months) + 14.days
                UserMailer.background_check_expiring(user, 14).deliver
                TwilioTextMessenger.new(user.phone_number, 'In order to keep your driver account in compliance, delivery.com requests an updated Motor Vehicle Report from you every 6 months. You have 14 days to update. Go to https://drivers.letsdodelivery.com/bgc/payment/ to update your Motor Vehicle Report.').call
            when (Date.current - 6.months) + 7.days
                UserMailer.background_check_expiring(user, 7).deliver
                TwilioTextMessenger.new(user.phone_number, 'In order to keep your driver account in compliance, delivery.com requests an updated Motor Vehicle Report from you every 6 months. You have 7 days to update. Go to https://drivers.letsdodelivery.com/bgc/payment/ to update your Motor Vehicle Report.').call
            when (Date.current - 6.months) + 3.days
                UserMailer.background_check_expiring(user, 3).deliver
                TwilioTextMessenger.new(user.phone_number, 'In order to keep your driver account in compliance, delivery.com requests an updated Motor Vehicle Report from you every 6 months. You have 3 days to update. Go to https://drivers.letsdodelivery.com/bgc/payment/ to update your Motor Vehicle Report.').call
            when (Date.current - 6.months) + 2.days
                UserMailer.background_check_expiring(user, 2).deliver
                TwilioTextMessenger.new(user.phone_number, 'In order to keep your driver account in compliance, delivery.com requests an updated Motor Vehicle Report from you every 6 months. You have 2 days to update. Go to https://drivers.letsdodelivery.com/bgc/payment/ to update your Motor Vehicle Report.').call
            when (Date.current - 6.months) + 1.days
                UserMailer.background_check_expiring(user, 1).deliver
                TwilioTextMessenger.new(user.phone_number, 'In order to keep your driver account in compliance, delivery.com requests an updated Motor Vehicle Report from you every 6 months. You have 1 days to update. Go to https://drivers.letsdodelivery.com/bgc/payment/ to update your Motor Vehicle Report.').call
            end
        end

        users = User.where('bgc_completed <= ?', Date.current - 6.months)
        users.update(inactive: true)
    end
end
