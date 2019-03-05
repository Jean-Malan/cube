class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  respond_to :html, :json, :xml

  # GET /profiles
  # GET /profiles.json
  def index
    @profile = User.get_current_profile(current_user.id)
    @current_user = current_user.profiles[0].id
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @current_user = current_user.profiles[0].id
  end

  def get_all_profiles
    # binding.pry
    @profiles = Profile.all
    respond_with(@profiles.to_json)
  end

  def get_all_friends
    id = profile_params[:id]
    @profiles = Profile.find(id)
    respond_with(@profiles.to_json)

  end

  def get_all_pending_requests
    @friends = current_user.profiles[0].pending_friends
    respond_with(@friends.to_json)
  end

  def get_all_friend_requests
    @friends = current_user.profiles[0].requested_friends
    respond_with(@friends.to_json)
  end

  def build_friend_request
    from = profile_params[:current_user].to_i
    to = profile_params[:friend_user].to_i
    @sender = Profile.find(from)
    @recipient = Profile.find(to)
    binding.pry
    @sender.friend_request(@recipient)
    respond_with(@profile.to_json)
    
  end

  def add_friend
    @to = User.find(to)
    @from = User.find(from)
    @to.friend_request(@from)
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
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    binding.pry
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
      params.require(:profile).permit(:username, :first_name, :friend_user, :current_user, :limit, :last_name, :address, :country, :city, :about, :postal_code, :avatar, :color)
    end
end
