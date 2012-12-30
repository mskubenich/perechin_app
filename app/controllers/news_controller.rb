# -*- encoding : utf-8 -*-
class NewsController < ApplicationController

  def new
    @news = News.new
    @title = "Add news"
  end

  def create
    @news = News.new(params[:news])
    if @news.save
      if params[:assets]
        params[:assets].each do |item|
          AttachedAsset.create(:news_id => @news.id, :asset => item[:asset])
        end
      end

      #@news.attached_assets.build(:asset => params[:assets])
     # @news.assets_array = params[:assets]

      flash[:success] = "Succesfully created news: " + @news.title
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

end
