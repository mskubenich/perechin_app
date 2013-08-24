class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  #before_filter :has_access?
  before_filter :admin_messages

  private

  #def has_access?
  #  role = (current_user && current_user.role )?current_user.role : Role.find_by_name("guest")
  #  action = Action.all(:conditions => {:controller => params[:controller], :action => params[:action], :method => request.method}).first
  #  permission = ControllerRolePermission.all(:conditions => {:role_id => role.id, :action_id => action.id}).first
  #  unless permission.has_access?
  #    flash[:error] = "Sorry, You don't have permission to access"
  #    redirect_to :back || root_path
  #  end
  #end

  def admin_messages
    if current_user && current_user.role.name == "admin"
      @admin_message = (JoinConfirmation.count + Work.where(:moderate => false).count).to_s
    end
  end
end
