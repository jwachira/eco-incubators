class Admin::PagesController < AdminController
  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
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
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to admin_page_url(@page), :notice => "Page has been successfully updated."
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    if @page.destroy
      flash[:notice] = "Page record has been successfully deleted"
    else
      flash[:error] = "We are not able to delete this record. Please try again"
    end
    redirect_to admin_pages_url
  end  
end
