class PagesController < ApplicationController

  def home
    @title = 'Home'

    ActiveRecord::Base.connection.execute("SET @limit = (SELECT created_at FROM news ORDER BY created_at DESC LIMIT 25,1);")
    @galleria_news = News.find_by_sql("SELECT * FROM news WHERE DATE(created_at) > DATE(@limit) ORDER BY view_count DESC LIMIT 10")
    if @galleria_news.blank?
      @galleria_news = News.find_by_sql("SELECT * FROM news ORDER BY created_at DESC LIMIT 10")
    end

    @last_news = News.all(:limit => 19, :order => 'created_at DESC', :select => "title, created_at, view_count, id, body")

    @last_articles = Article.all(:limit => 19, :order => 'created_at DESC', :select => "title, created_at, view_count, id, body")

    @tags = News.tags

    last_arts = Work.all(:limit => 1, :order => 'created_at DESC')
    @last_art = last_arts.first if last_arts.count > 0
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
