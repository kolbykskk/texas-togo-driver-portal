class PaymentSheetPolicy < ApplicationPolicy
    attr_reader :user, :post

    def initialize(user, post)
        @user = user
        @post = post
    end

    def disbursments?
      user.admin == true
    end
end