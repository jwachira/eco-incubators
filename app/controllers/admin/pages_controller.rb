class Admin::PagesController < AdminController
  before_filter :page_id, :only => [:show, :edit, :update, :destroy]
  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(page_id)
  end

  def new
    @page = Page.new
    6.times{@page.photos.build}
  end

  def edit
    @page = Page.find(page_id)
    6.times{@page.photos.build} if @page.photos.size < 2
  end

  def create
    @page = Page.new(params[:page])

    if @page.save
      redirect_to admin_pages_url, :notice => "Page has been successfully created."
    else
      render :action => "new"
    end
  end

  def update
    @page = Page.find(page_id)
    if @page.update_attributes(params[:page])
      redirect_to admin_page_url(@page), :notice => "Page has been successfully updated."
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(page_id)
    if @page.destroy
      flash[:notice] = "Page record has been successfully deleted"
    else
      flash[:error] = "We are not able to delete this record. Please try again"
    end
    redirect_to admin_pages_url
  end  
  
  def page_id
    page_id = String(params[:id]).numeric_id
  end
end
