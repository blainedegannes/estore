class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.f_name
  end
  
  def new
  end

end
