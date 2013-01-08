class PagesController < ApplicationController

  def home
    @title = 'Home'
    @news = News.all(:limit => 4, :order => 'created_at DESC')
  end

  def contact
    @title = 'Contact'
  end

  def about
    @title = 'About'
  end

  def help
    @title = 'Help'
  end
end
