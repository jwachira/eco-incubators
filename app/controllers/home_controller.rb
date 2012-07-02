class HomeController < ApplicationController
  
  def index
   @carousel_pages        = Page.carousel
   @top_selling           = Page.top_selling
   @customer_testimonials = Page.customer_testimonials
  end
end
