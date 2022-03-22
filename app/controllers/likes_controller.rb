class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]
  after_action :add_like_notifications_to_db, only: %i[ create ]

  # GET /likes or /likes.json
  def index
    @likes = Like.where(tweet_id: params[:tweet_id]).all.order("created_at DESC")
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    @like = Like.new(like_params)
    @like.save
    respond_to do |format|
      if @like.save
        format.html {  }
        format.json {  }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { render :show, notice: "Like was successfully updated." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy

    respond_to do |format|
      format.html { redirect_to likes_url, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:tweet_id, :user_id)
    end
    def add_like_notifications_to_db     
      notifications = []
      last_like_from_user = Like.where(user_id:current_user.id).last
      tweet = Tweet.find_by(id: last_like_from_user.tweet_id)
      notifications.push({ seen: false, notification_type: 3, user_id: tweet.user.id, from: current_user.id, tweet_id: tweet.id })
      Notification.insert_all(notifications)
    end
end
