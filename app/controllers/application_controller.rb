class ApplicationController < ActionController::Base
  before_action :get_users

  def get_users
      @profiles = []
      Profile.all.order("first_name DESC").select{|p| @profiles << {id: p.id, name: p.first_name + " " + p.last_name} }
  end
  
  

end
