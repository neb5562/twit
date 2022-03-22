class ApplicationController < ActionController::Base
    before_action :set_notifications
    def after_sign_in_path_for(resource)
        session["user_return_to"] || root_path
    end
    
    def search
        if params[:query].blank? || params[:query].length <= 1
            flash[:alert] = "your search criteria is invalid. Please try using valid keywords"
            redirect_to root_path
        end
        @tweets = Tweet.where("tweet LIKE ?", "%#{params[:query]}%").paginate(page: params[:page]).order("created_at DESC")
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
