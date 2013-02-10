class PagesController < ApplicationController

  def home
    @title = 'Home'
    @galleria_news = News.all(:conditions => ["DATE(created_at) > DATE(?)", Time.now - 1.month], :order => 'view_count DESC', :limit => 5)
    @last_news = News.all(:limit => 7, :order => 'created_at DESC', :select => "title, created_at, view_count, id")
    @last_articles = Article.all(:limit => 4, :order => 'created_at DESC', :select => "title, created_at, view_count, id")
    @tags = ActiveRecord::Base.connection.select_all("SELECT tags.id, tags.title,
                                                             (SELECT count(id) FROM news_tags WHERE tag_id = tags.id)+
                                                             (SELECT count(id) FROM articles_tags WHERE tag_id = tags.id) AS totalcount
                            FROM tags
                            ORDER BY totalcount DESC LIMIT 20;")
    max_size = 30
    min_size = 15
    max_value = @tags.first['totalcount'].to_i
    min_value = @tags.last['totalcount'].to_i
    @tags.each do |tag|
      tag['size'] = (((tag['totalcount'].to_i * (max_size-min_size))+min_value)/((max_value-min_value))+min_size)
      puts tag['totalcount']
    end
    @tags = @tags.sort_by{ |tag| tag['id'] }

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
