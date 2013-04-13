class PagesController < ApplicationController

  def home
    @title = 'Home'

    ActiveRecord::Base.connection.execute("SET @limit = (SELECT created_at FROM news ORDER BY created_at DESC LIMIT 25,1);")
    @galleria_news = News.find_by_sql("SELECT * FROM news WHERE DATE(created_at) > DATE(@limit) ORDER BY view_count DESC LIMIT 10")
    if @galleria_news.blank?
      @galleria_news = News.find_by_sql("SELECT * FROM news ORDER BY created_at DESC LIMIT 10")
    end

    @last_news = News.all(:limit => 30, :order => 'created_at DESC', :select => "title, created_at, view_count, id")

    @last_articles = Article.all(:limit => 10, :order => 'created_at DESC', :select => "title, created_at, view_count, id")

    @tags = News.tags
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
