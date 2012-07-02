class PagesController < ApplicationController
  
 def show
  page_id = String(params[:id]).numeric_id
  @page = Page.find(page_id)
 end
 
end
