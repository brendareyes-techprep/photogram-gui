class UsersController < ApplicationController
  def index
    matching_user = User.all.order({:username => :asc})
    render({ :template => "user_templates/index"})
  end 
end
