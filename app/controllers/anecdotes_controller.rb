class AnecdotesController < ApplicationController
  def index
    @anecdotes = Anecdote.search(params[:page])
    @title = "Anecdotes"
  end

  def new
    @anecdote = Anecdote.new
    @title = "Add anecdote"
  end

  def create
    @anecdote = Anecdote.create(params[:anecdote])
    if @anecdote.save
      #save attached images
      require 'nokogiri'
      page =  Nokogiri::HTML(params[:anecdote][:body])
      page.xpath("//img[@asset]").each do |img|
        if params[:images] && params[:images]['asset'+img['assetnum']]
          image = AttachedAsset.create(:anecdote_id => @anecdote.id, :asset => params[:images]['asset'+img['assetnum']])
          img.attribute('src').value = image.asset.url(:original)
          img['asset_id'] = image.id.to_s
          params[:images].delete('asset'+img['assetnum'])
          img.remove_attribute 'assetnum'
          img.remove_attribute 'asset'
        end
      end
      @anecdote.body = page.css("body:first").inner_html

      @anecdote.save
      flash[:success] = "Succesfully created anecdote: " + @anecdote.title
      redirect_to anecdotes_path
    else
      flash[:success] = "Error created anecdote"
      render 'new'
    end
  end

  def edit
    @anecdote = Anecdote.find(params[:id])
    @title = "Change anecdote"
  end

  def update
    @anecdote = Anecdote.find(params[:id])
    if @anecdote.update_attributes(params[:anecdote])
      #save attached images
      require 'nokogiri'
      page =  Nokogiri::HTML(params[:anecdote][:body])

      @anecdote.attached_assets.each do |image|
        image_present = false
        page.xpath("//img[@asset_id=#{image.id.to_s}]").each do |img|
          image_present = true
        end
        unless image_present
          image.destroy
        end
      end

      page.xpath("//img[@asset]").each do |img|
        if params[:images] && params[:images]['asset'+img['assetnum']]
          image = AttachedAsset.create(:anecdote_id => @anecdote.id, :asset => params[:images]['asset'+img['assetnum']])
          img.attribute('src').value = image.asset.url(:original)
          img['asset_id'] = image.id.to_s
          params[:images].delete('asset'+img['assetnum'])
          img.remove_attribute 'assetnum'
          img.remove_attribute 'asset'
        end
      end
      @anecdote.body = page.css("body:first").inner_html

      @anecdote.save
      flash[:success] = "Succesfully changed anecdote: " + @anecdote.title
      redirect_to anecdotes_path
    else
      flash[:success] = "Error changed anecdote"
      render 'edit'
    end
  end

  def destroy
    Anecdote.find(params[:id]).destroy
    redirect_to anecdotes_path
  end
end
