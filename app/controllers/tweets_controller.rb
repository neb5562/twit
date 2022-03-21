class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  after_action :add_notifications_to_db, only: [:create]
  # GET /tweets or /tweets.json
  def index
    #@tweets = Tweet.all.order("created_at DESC") #limit(5).
    @tweets = Tweet.where(:deleted => false).paginate(page: params[:page]).order("created_at DESC")
    @tweet = Tweet.new
    @user = current_user
  end

  # GET /tweets/1 or /tweets/1.json
  def show
    
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweet.build
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = current_user.tweet.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def retweet
    @tweet = Tweet.find_by(id: params[:id], deleted: false)
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to tweet_url(@tweet), notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    respond_to do |format|
      if @tweet.user_id == current_user.id
        @tweet.destroy
        format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to tweets_url, alert: "No permission" }
        format.json { head :no_content }
      end
    end
  end
  private
    def add_notifications_to_db
      followers = Follower.where(user_id: current_user.id)
      notifications = []
      followers.each do |f|
        notifications.push({ seen: false, notification_type: 1, user_id: f.follow, from: current_user.id, tweet_id: Tweet.where(user_id:current_user.id).last.id })
      end
      Notification.insert_all(notifications)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:tweet, :retweet_tweet_id)
    end
end
