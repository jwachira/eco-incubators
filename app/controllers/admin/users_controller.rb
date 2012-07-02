class Admin::UsersController < AdminController
  respond_to :html, :js
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(:action => "index", :notice => 'User was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to(:action => "index", :notice => 'User was successfully update.')
    else
      render :action => "edit"
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to(:action => "index", :notice => 'User has been deleted')
  end
  
end
