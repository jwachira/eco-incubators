class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      flash[:notice] = "Category has been successfully created."
      redirect_to admin_categories_url
    else
      render :action => "new"
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Category has been successfully updated."
      redirect_to admin_category_url(@category)
    else
      render :action => "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice] = "Category record has been successfully deleted"
    else
      flash[:error] = "We are not able to delete this record. Please try again"
    end
    redirect_to admin_categories_url
  end
  
end
