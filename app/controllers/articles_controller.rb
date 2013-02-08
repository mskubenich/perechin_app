class ArticlesController < ApplicationController

    def new
      @article = Article.new
      @title = "Add article"
    end

    def create
      @article = current_user.articles.build(params[:article])
      if @article.save
        #save attached images
        require 'nokogiri'
        page =  Nokogiri::HTML(params[:article][:body])
        page.xpath("//img[@asset]").each do |img|
          if params[:images]['asset'+img['assetnum']]
            image = AttachedAsset.create(:article_id => @article.id, :asset => params[:images]['asset'+img['assetnum']])
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
          params[:images].each do |key, value|                                                      f
          AttachedAsset.create(:asset_id => @asset.id, :asset => value)
          end
        end
        @article.body = page.css("body:first").inner_html
        #save tags
        tags = []
        params[:tags].each do |key, value|
          tag = Tag.find_by_title key
          unless tag
            tag = Tag.create(:title => key)
          end
          tags << tag
        end
        @article.tags = tags

        @article.view_count = 0

        @article.save
        flash[:success] = "Succesfully created article: " + @article.title
        redirect_to articles_path
      else
        flash[:success] = "Error created article"
        render 'new'
      end
    end

    def edit
      @article = Article.find params[:id]
      @title = "Add article"
    end

    def update
      @article = Article.find params[:id]
      if @article.update_attributes params[:article]
        require 'nokogiri'
        page =  Nokogiri::HTML(params[:article][:body])

        @article.attached_assets.each do |image|
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
            image = AttachedAsset.create(:article_id => @article.id, :asset => params[:images]['asset'+img['assetnum']])
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
            AttachedAsset.create(:article_id => @article.id, :asset => value)
          end
        end
        @article.body = page.css("body:first").inner_html

        #save tags
        tags = []
        params[:tags].each do |key, value|
          tag = Tag.find_by_title key
          unless tag
            tag = Tag.create(:title => key)
          end
          tags << tag
        end
        @article.tags = tags

        @article.save
        flash[:success] = "Succesfully changed article: " + @article.title
        redirect_to articles_path
      else
        flash[:success] = "Error created article"
        render 'new'
      end
    end

    def show
      @article = Article.find(params[:id])
      sql = ActiveRecord::Base.connection()
      sql.execute("UPDATE articles SET view_count = #{(@article.view_count + 1).to_s} WHERE id = #{(@article.id).to_s}")
    end

    def create_comment
      @comment = Comment.create(:user_id => current_user.id, :article_id => params[:article_id], :text => params[:text])
      if @comment.save
        render :partial => 'comment', :locals => {:comment => @comment}
      end
    end

    def destroy
      @article = Article.find(params[:id]).destroy
      redirect_to articles_path
    end

    def index
      @articles = Article.search(params[:page], params[:tag])
      @tag = Tag.find(params[:tag]) if params[:tag]
    end

end
