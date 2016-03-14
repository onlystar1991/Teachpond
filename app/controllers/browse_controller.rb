class BrowseController < ApplicationController

  def index
    if params[:category_id]
      @posts = Category.find(params[:category_id]).posts
      @search_title = Category.find(params[:category_id]).title << " field"
    elsif params[:location_id]
      @posts = Location.find(params[:location_id]).posts
      puts "----Location------"
      puts @posts.inspect

      @search_title = Location.find(params[:location_id]).city
    elsif params[:city]
      location = Location.find_by(:city => params[:city])
      if !location.nil?
        @posts = location.posts
      else
        @posts = []
      end
      @search_title = params[:city]
    elsif params[:search]
      location = Location.find_by(:city => params[:search])
      if !location.nil?
        @posts = location.posts
      else
        search_term = params[:search]
        @posts = Post.where("title LIKE ?", "%#{search_term}%")
      end
      @search_title = params[:search]
    else
      @posts = Post.all
      @requests = Request.all
    end
    
    @categories = Category.all
    @normal_locations = Location.where(:normal => true)
    @additional_locations = Location.where(:normal => false)
    gon.additional_locations = @additional_locations
  end

  def requests
    if params[:category_id]
      @requests = Category.find(params[:category_id]).requests
      @search_title = Category.find(params[:category_id]).title << " field"
      puts "-------location---------"
      puts @requests.inspect
      
    elsif params[:location_id]
      @requests = Location.find(params[:location_id]).requests

      @search_title = Location.find(params[:location_id]).city
    elsif params[:city]
      location = Location.find_by(:city => params[:city])
      if !location.nil?
        @requests = location.requests 
      else
        @requests = []
      end
      @search_title = params[:city]
    elsif params[:search]
      location = Location.find_by(:city => params[:search])
      if !location.nil?
        @requests = location.requests
      else
        search_term = params[:search]
        @requests = Request.where("title LIKE ?", "%#{search_term}%")
      end
      @search_title = params[:search]
    else
      @requests = Request.all
    end
    
    @categories = Category.all
    @normal_locations = Location.where(:normal => true)
    @additional_locations = Location.where(:normal => false)
    gon.additional_locations = @additional_locations
  end
end
