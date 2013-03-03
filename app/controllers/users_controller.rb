class UsersController < ApplicationController
  def new
    @user = User.new
    @title = 'Sign Up'
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @last_comments = @user.comments.all(:limit => 10)
  end

  def create
    @user = User.new(params[:user])
    @user.role = Role.find_by_name "user"
    if @user.save
      flash[:success] = "Check you mail and confirm registration!"
      redirect_to root_path
    else
      @title = "Sign Up"
      render 'new'
    end
  end

end
