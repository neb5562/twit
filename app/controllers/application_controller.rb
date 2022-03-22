class ApplicationController < ActionController::Base
    before_action :set_notifications
    def after_sign_in_path_for(resource)
        session["user_return_to"] || root_path
    end

    private
    def set_notifications
        if current_user.nil?
            @notifications = nil
        else
            @notifications = Notification.where(user_id: current_user.id).all.order("created_at DESC")
        end
        
    end
end
