class ArtsController < ApplicationController
  def index
    @title = "Art"
    @art_categories = ArtCategory.all
    @category = ArtCategory.find(params[:art_category]) if params[:art_category]
    @art_subcategory = ArtSubcategory.find(params[:art_subcategory]) if params[:art_subcategory]
    role_author = Role.find_by_name("author")
    @authors = User.where(:role_id => role_author.id)
    @works = Work.all
  end

  def show
    @work = Work.find params[:id]
  end

  def new
    @title = "Create Work"
    @work = Work.new
    @art_categories = ArtCategory.all
  end

  def create
    @work = current_user.works.build(params[:work])
    if @work.save
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
end
