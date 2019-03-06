class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :verify_profile, :except => [:new, :create, :index]
  respond_to :html, :json, :xml
  before_action :authenticate_profile_user, only: [:edit, :update]
  before_action :authenticate_user!

  # GET /profiles
  # GET /profiles.json
  def index
    @profile = User.get_current_profile(current_user.id)
    @user = current_user.profiles[0].id
    @friends = Profile.get_friend_ids(current_user.id)
    @pending_friends = Profile.get_pending_friend_ids(current_user.id)
  end

  def verify_profile
    if Profile.verify_user_profile(current_user.id)
      return true 
    else
      redirect_to new_profile_url
    end
  end

  def authenticate_profile_user
    if @profile.user_id != current_user.id
      redirect_to profiles_url
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @user = current_user.profiles[0].id
    @friends = Profile.get_friend_ids(current_user.id)
    @pending_friends = Profile.get_pending_friend_ids(current_user.id)
  end

  def get_all_profiles
    @profiles = Profile.all
    respond_with(@profiles.to_json)
  end

  def get_friends
    id = params.keys[0]
    @friends = Profile.find(id).friends
    respond_with(@friends.to_json)

  end

  def get_all_pending_requests
    @friends = current_user.profiles[0].pending_friends
    respond_with(@friends.to_json)
  end

  def get_all_friend_requests
    @friends = current_user.profiles[0].requested_friends
    respond_with(@friends.to_json)
  end

  # def accept_friend_request
  #   bindding.pry
  #   @recipient = Profile.find(profile_params[:recipient].to_i)
  #   @sender = Profile.find(profile_params[:sender].to_i)
  #   @recipient.accept_request(@sender)
  #   respond_with(@profile.to_json)
  # end

  def handle_friend_request
    @sender = Profile.find(profile_params[:sender].to_i)
    @recipient = current_user.profiles[0]
    
    @recipient.accept_request(@sender)
    respond_with(@recipient.to_json)
  end

  def add_friend
    to = profile_params[:to].to_i
    from = current_user.id
    @to = Profile.find(to)
    @from = User.find(from).profiles[0]
    @from.friend_request(@to)
  end

  # GET /profiles/new
  def new    
    @profile = Profile.new
  
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    @profile.color = "#" + (Random.new.bytes(3).unpack("H*")[0]).to_s
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @profile.avatar = profile_params[:avatar]
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:username, :sender, :first_name, :to, :from, :friend_user, :current_user, :limit, :last_name, :address, :country, :city, :about, :postal_code, :avatar, :color)
    end
end
