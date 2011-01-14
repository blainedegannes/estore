class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.f_name
  end
  
  def new
    @user = User.new
  end
  
  def create
      @user = User.new(params[:user])
      if @user.save
        flash[:success] = "Welcome to Entree, Your Main Course for Lifestyle!"
        redirect_to @user
      else
        @title = "Sign up"
        render 'new'
    end
  end
end