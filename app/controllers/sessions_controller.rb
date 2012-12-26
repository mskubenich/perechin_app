class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination or you are not activated user"
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  def join_confirm
    confirm = JoinConfirmation.find_by_activation_code params[:activation_code]
    if confirm
       confirm.destroy
       flash[:success] = "Activation confirm successful. You can enter with you email/pass."
    end
    redirect_to root_path
  end
end
