class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        session["user_return_to"] || root_path
    end
    #before_action :set_notifications

    private
    def set_notifications
     #@notifications = nil
    end
end
