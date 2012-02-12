class ApplicationController < ActionController::Base
  protect_from_forgery


  private  

  def markdown
    renderer = Redcarpet::Render::HTML.new(
      filter_html: true,
      no_images: true,
      safe_links_only: true,
      hard_wrap: true
    )
    Redcarpet::Markdown.new(renderer,
      autolink: true,
      space_after_headers: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      space_after_headers: true
    ) 
  end
  
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end  
  
  helper_method :current_user
  
end
