class SessionsController < Devise::SessionsController
    skip_before_action :is_active?

end
