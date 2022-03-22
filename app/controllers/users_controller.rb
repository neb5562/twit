class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  before_action :authenticate_user!, only: [:profile]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  def profile
    @user = User.find_by(username: params[:name].to_s[1..-1])
    @tweets = @user.tweet.paginate(page: params[:page]).order("created_at DESC")
  end

  def follow
    @follow = Follower.new(user_id: params[:user_id], follow: params[:follow])

    respond_to do |format|
      if @follow.save
        format.html {}
        format.json { render json: @follow.to_json }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end

  end

  def unfollow
    @unfollow = Follower.find_by(user_id: params[:user_id], follow: params[:follow]).destroy

    respond_to do |format|
        format.html {}
        format.json { render json: @unfollow.to_json }
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end

  def sign_up_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
  def account_update_params 
  params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :current_password)
  end

end


