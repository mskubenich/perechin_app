class Admin::PagesController < ApplicationController
  def index
    @confirmations = JoinConfirmation.all
    @not_moderated_works = Work.where(:moderate => false)
  end
end
