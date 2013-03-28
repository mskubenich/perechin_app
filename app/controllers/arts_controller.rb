class ArtsController < ApplicationController
  def index
    @title = "Art"
    @art_categories = ArtCategory.all
    role_author = Role.find_by_name("author")
    @authors = User.where(:role_id => role_author.id)

    @works = Work.search(params[:page], params[:art_category].to_s, params[:art_subcategory].to_s, params[:author_id].to_s, (current_user && (current_user.role.name == "admin" || current_user.role.name == "author" )))

    @category = ArtCategory.find(params[:art_category]) if params[:art_category]
    @art_subcategory = ArtSubcategory.find(params[:art_subcategory]) if params[:art_subcategory]
    @author = User.find(params[:author_id]) if params[:author_id]
  end

  def show
    @art_categories = ArtCategory.all
    @category = ArtCategory.find(params[:art_category]) if params[:art_category]
    @art_subcategory = ArtSubcategory.find(params[:art_subcategory]) if params[:art_subcategory]
    role_author = Role.find_by_name("author")
    @authors = User.where(:role_id => role_author.id)
    @work = Work.find params[:id]
    @title = @work.title
    sql = ActiveRecord::Base.connection()
    sql.execute("UPDATE works SET view_count = #{(@work.view_count + 1).to_s} WHERE id = #{(@work.id).to_s}")
  end

  def new
    @title = "Create Work"
    @work = Work.new
    @art_categories = ArtCategory.all
  end

  def create
    params[:work][:moderate] = false
    params[:work][:view_count] = 0
    @work = current_user.works.build(params[:work])
    if @work.save
      require 'nokogiri'
      page =  Nokogiri::HTML(params[:work][:body])
      page.xpath("//img[@asset]").each do |img|
        if params[:images] && params[:images]['asset'+img['assetnum']]
          image = AttachedAsset.create(:work_id => @work.id, :asset => params[:images]['asset'+img['assetnum']])
          img.attribute('src').value = image.asset.url(:original)
          img['asset_id'] = image.id.to_s
          params[:images].delete('asset'+img['assetnum'])
          img.remove_attribute 'assetnum'
          img.remove_attribute 'asset'
        end
      end
      @work.update_attribute(:body, page.css("body:first").inner_html)
      flash[:success] = "Succesfully created work: " + @work.title
      redirect_to arts_path
    else
      flash[:success] = "Error created work"
      @art_categories = ArtCategory.all
      render 'new'
    end
  end

  def edit
    unless current_user.role.name == "admin" || current_user == @work.author
      flash[:success] = "You dont have permissions to access this action"
      redirect_to 'index'
    end
    @title = "Edit Work"
    @work = Work.find(params[:id])
    @art_categories = ArtCategory.all
  end

  def update
    unless current_user.role.name == "admin" || current_user == @work.author
      flash[:success] = "You dont have permissions to access this action"
      render 'index'
    end
    @work = Work.find(params[:id])
    if @work.update_attributes params[:work]
      require 'nokogiri'
      page =  Nokogiri::HTML(params[:work][:body])

      @work.attached_assets.each do |image|
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
          image = AttachedAsset.create(:work_id => @work.id, :asset => params[:images]['asset'+img['assetnum']])
          img.attribute('src').value = image.asset.url(:original)
          img['asset_id'] = image.id.to_s
          params[:images].delete('asset'+img['assetnum'])
          img.remove_attribute 'assetnum'
          img.remove_attribute 'asset'
        end
      end

      @work.update_attribute(:body, page.css("body:first").inner_html)
      flash[:success] = "Succesfully changed work: " + @work.title
      redirect_to arts_path
    else
      flash[:success] = "Error created work"
      @art_categories = ArtCategory.all
      render 'edit'
    end
  end

  def destroy
    unless current_user.role.name == "admin" || current_user == @work.author
      flash[:success] = "You dont have permissions to access this action"
      render 'index'
    end
    Work.find(params[:id]).destroy
    redirect_to arts_path
  end

  def subcategories_for_category
    if params[:art_category]
      cat = ArtCategory.find(params[:art_category])
      options = ""
      cat.art_subcategories.each do |subcat|
        options += "<option value='"+subcat.id.to_s+"'>"+subcat.title+"</option>"
      end
      render :text => options
    else
      render :text => "<option>error</option>"
    end
  end

  def create_comment
    @comment = Comment.create(:user_id => current_user.id, :work_id => params[:art_id], :text => params[:text])
    if @comment.save
      render :partial => 'layouts/comment', :locals => {:comment => @comment}
    end
  end

end
