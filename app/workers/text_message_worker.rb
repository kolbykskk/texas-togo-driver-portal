class TextMessageWorker
  include Sidekiq::Worker

  def perform(locations, message)
    locations.each do |location|
      loc = Location.find(location)
      if loc
        loc.users.each do |user|
          unless user.inactive
            TwilioTextMessenger.new(user.phone_number, message).call
          end
        end
      end
    end
  end
end
