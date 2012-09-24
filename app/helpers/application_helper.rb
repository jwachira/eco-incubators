module ApplicationHelper
  def title(page_title, show_title = true)
    @show_title = show_title
    content_for(:title) { page_title.to_s }
  end

  def show_title?
    @show_title
  end
  
  def contact_us
    Page.contact_us
  end

  def about_us
    Page.about_us
  end
  
  
end
