class PagesController < ApplicationController

  def home
    @title = 'Home'
    @news = News.order('created_at').all.reverse
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
