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
    @user = User.find(params[:id])
  end

  def change_name
    if params[:name]
      user = current_user
      new_user = User.new(:name => params[:name])
      new_user.valid?
      if !new_user.errors.has_key? :name
        user.update_attribute(:name, params[:name])
        render :text => "ok"
      else
        message = "name "
        new_user.errors[:name].each do |mess|
          message += mess
        end
        render :text => message
      end
    end
  end

  def change_password

  end

  def change_avatar

  end

  def change_about_me
    if params[:about_me]
      user = current_user
      new_user = User.new(:about_me => params[:about_me])
      new_user.valid?
      if !new_user.errors.has_key? :about_me
        user.update_attribute(:about_me, params[:about_me])
        render :text => "ok"
      else
        message = "about_me "
        new_user.errors[:about_me].each do |mess|
          message += mess
        end
        render :text => message
      end
    end
  end

end
