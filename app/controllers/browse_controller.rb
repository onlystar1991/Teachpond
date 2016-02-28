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
    elsif params[:q]
      search_term = params[:q]
      @posts = Post.where("title LIKE ?", "%#{search_term}%")
      @requests = Request.where("title LIKE ?", "%#{search_term}%")
    else
      @posts = Post.all
      @requests = Request.all
    end

    @categories = Category.all
    @locations = Location.where(:normal => true)
  end

end
