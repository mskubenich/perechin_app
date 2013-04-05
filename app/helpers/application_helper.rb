# coding: utf-8

module ApplicationHelper

  def title
    base_title = "Perechin.net"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def month(month_number)
    %w'січня лютого березня квітня травня червня липня серпня вересня жовтня листопада грудня'[month_number - 1]
  end

  def preview_from_body(body)
    require 'nokogiri'
    page =  Nokogiri::HTML(body)
    page.css("img").each do |img|
      img.remove
    end
    page =  Nokogiri::HTML(page.css("body:first").inner_html[0..300])
    page.css("body:first").inner_html
  end

  def daily_anecdote
    count = Anecdote.count
    available = rand(20)
    if count < available
       available = rand(count)
    end

    Anecdote.all(:order => 'created_at DESC', :limit => 1, :offset => available).first
  end

  def last_news_load
    News.select("title, id, created_at").all(:order => 'created_at DESC', :limit => 10)
  end

  def last_articles_load
    Article.select("title, id, created_at").all(:order => 'created_at DESC', :limit => 10)
  end


end
