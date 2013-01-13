# -*- encoding : utf-8 -*-
class NewsController < ApplicationController

  def new
    @news = News.new
    @title = "Add news"
  end

  def create
    @news = current_user.news.build(params[:news])
    if @news.save
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
      @news.save
      #  if params[:assets]
      #    params[:assets].each do |item|
      #      AttachedAsset.create(:news_id => @news.id, :asset => item[:asset])
      #    end
      #  end
      #
      #  #@news.attached_assets.build(:asset => params[:assets])
      # # @news.assets_array = params[:assets]
      #
      flash[:success] = "Succesfully created news: " + @news.title
      redirect_to root_path
    else
      flash[:success] = "Error created news"
      render 'new'
    end

    #<div class="field">
    #<%= f.label :asset %>
    #  <%= file_field_tag 'asset', :multiple => true, :name => 'assets[][asset]' %>
    #</div>
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
  end

  def create_comment
    @comment = Comment.create(:user_id => current_user.id, :news_id => params[:news_id], :text => params[:text])
    if @comment.save
      render :partial => 'comment', :locals => {:comment => @comment}
    end
  end

  def destroy
    @news = News.find(params[:id]).destroy
    redirect_to :back
  end

  def index
    @news = News.search(params[:page])
  end

end
