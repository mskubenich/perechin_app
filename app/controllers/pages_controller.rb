class PagesController < ApplicationController

  def home
    @title = 'Home'
    @galleria_news = News.all(:conditions => ["DATE(created_at) > DATE(?)", Time.now - 1.month], :order => 'view_count DESC', :limit => 5)
    @last_news = News.all(:limit => 7, :order => 'created_at DESC', :select => "title, created_at, view_count, id")
    @last_articles = Article.all(:limit => 4, :order => 'created_at DESC', :select => "title, created_at, view_count, id")
    @tags =
    render :layout => 'home_layout'
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
