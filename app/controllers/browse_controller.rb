class BrowseController < ApplicationController

  def index
    if params[:category_id] && params[:q]
      search_term = params[:q]
      posts = Category.find(params[:category_id]).posts
      requests = Category.find(params[:category_id]).requests
      @posts = posts.where("title LIKE ?", "%#{search_term}%")
      @requests = requests.where("title LIKE ?", "%#{search_term}%")
    elsif params[:category_id]
      @posts = Category.find(params[:category_id]).posts
      @requests = Category.find(params[:category_id]).requests
    elsif params[:location_id] && params[:q]
      search_term = params[:q]
      posts = Location.find(params[:location_id]).posts
      requests = Location.find(params[:location_id]).requests
      @posts = posts.where("title LIKE ?", "%#{search_term}%")
      @requests = requests.where("title LIKE ?", "%#{search_term}%")
      @search_title = Location.find(params[:location_id]).city
    elsif params[:location_id]
      @posts = Location.find(params[:location_id]).posts
      @requests = Location.find(params[:location_id]).requests
      @search_title = Location.find(params[:location_id]).city
    elsif params[:city]
      location = Location.find_by(:city => params[:city])
      if !location.nil?
        @posts = location.posts
        @requests = location.requests 
      else
        @posts = []
        @requests = []
      end
      @search_title = params[:city]
    else
      @posts = Post.all
      @requests = Request.all
    end
    
    @categories = Category.all
    @normal_locations = Location.where(:normal => true)
    @additional_locations = Location.where(:normal => false)
    gon.additional_locations = @additional_locations
  end

end
