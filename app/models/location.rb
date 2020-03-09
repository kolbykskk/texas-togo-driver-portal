class Location < ApplicationRecord
    has_many :users

    def display_name
        "#{self.name} (#{self.users.count})"
    end
end
