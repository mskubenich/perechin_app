class UsersController < ApplicationController
  def new
    @user = User.new
    @title = 'Sign Up'
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @last_comments = @user.comments.all(:limit => 10, :order =>"created_at desc")
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

  def edit

  end

  def change_name

  end

  def change_password

  end

  def change_avatar

  end

  def change_about_me

  end

end
