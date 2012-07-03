class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
     redirect_to root_path, :alert => exception.message
   end
   
   
   layout :layout_by_resource

   protected

   def layout_by_resource
     if devise_controller?
       "admin"
     else
       "application"
     end
   end
end
