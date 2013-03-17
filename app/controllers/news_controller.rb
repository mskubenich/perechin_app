# -*- encoding : utf-8 -*-
class NewsController < ApplicationController

  def new
    @news = News.new
    @title = "Add news"
  end

  def create
    @news = current_user.news.build(params[:news])
    if @news.save
      #save attached images
      require 'nokogiri'
      page =  Nokogiri::HTML(params[:news][:body])
      page.xpath("//img[@asset]").each do |img|
        if params[:images]['asset'+img['assetnum']]
          image = AttachedAsset.create(:news_id => @news.id, :asset => params[:images]['asset'+img['assetnum']])
          img.attribute('src').value = image.asset.url(:original)
          img['asset_id'] = image.id.to_s
          params[:images].delete('asset'+img['assetnum'])
          img.remove_attribute 'assetnum'
          img.remove_attribute 'asset'
        else
          img.replace ""
        end
      end
      if params[:images]
        params[:images].each do |key, value|
          AttachedAsset.create(:news_id => @news.id, :asset => value)
        end
      end
      @news.body = page.css("body:first").inner_html
      #save tags
      tags = []
      if params[:tags]
        params[:tags].each do |key, value|
          tag = Tag.find_by_title key
          unless tag
            tag = Tag.create(:title => key)
          end
          tags << tag
        end
      end
      @news.tags = tags

      @news.view_count = 0

      @news.save
      flash[:success] = "Succesfully created news: " + @news.title
      redirect_to root_path
    else
      flash[:success] = "Error created news"
      render 'new'
    end
  end

  def edit
    @news = News.find params[:id]
    @title = "Add news"
  end

  def update
    @news = News.find params[:id]
    if @news.update_attributes params[:news]
      require 'nokogiri'
      page =  Nokogiri::HTML(params[:news][:body])

      @news.attached_assets.each do |image|
        image_present = false
        page.xpath("//img[@asset_id=#{image.id.to_s}]").each do |img|
          image_present = true
        end
        unless image_present
          image.destroy
        end
      end

      page.xpath("//img[@asset]").each do |img|
        if params[:images]['asset'+img['assetnum']]
          image = AttachedAsset.create(:news_id => @news.id, :asset => params[:images]['asset'+img['assetnum']])
          img.attribute('src').value = image.asset.url(:original)
          img['asset_id'] = image.id.to_s
          params[:images].delete('asset'+img['assetnum'])
          img.remove_attribute 'assetnum'
          img.remove_attribute 'asset'
        else
          img.replace ""
        end
      end
      if params[:images]
        params[:images].each do |key, value|
          AttachedAsset.create(:news_id => @news.id, :asset => value)
        end
      end
      @news.body = page.css("body:first").inner_html

      #save tags
      tags = []
      params[:tags].each do |key, value|
        tag = Tag.find_by_title key
        unless tag
          tag = Tag.create(:title => key)
        end
        tags << tag
      end
      @news.tags = tags

      @news.save
      flash[:success] = "Succesfully changed news: " + @news.title
      redirect_to root_path
    else
      flash[:success] = "Error created news"
      render 'new'
    end
  end

  def show
    @news = News.find(params[:id])
    sql = ActiveRecord::Base.connection()
    sql.execute("UPDATE news SET view_count = #{(@news.view_count + 1).to_s} WHERE id = #{(@news.id).to_s}")
    @tags = News.tags
  end

  def create_comment
    @comment = Comment.create(:user_id => current_user.id, :news_id => params[:news_id], :text => params[:text])
    if @comment.save
      render :partial => 'comment', :locals => {:comment => @comment}
    end
  end

  def destroy
    @news = News.find(params[:id]).destroy
    redirect_to news_index_path
  end

  def index
    @news = News.search(params[:page], params[:tag])
    @tag = Tag.find(params[:tag]) if params[:tag]
    @tags = News.tags
  end

end
