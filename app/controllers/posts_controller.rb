class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :all_categories, only: [:index, :new]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :locations


  def index
    if params[:category_id] && params[:q]
      search_term = params[:q]
      posts = Category.find(params[:category_id]).posts
      @posts = posts.where("title LIKE ?", "%#{search_term}%")
    elsif params[:category_id]
      @posts = Category.find(params[:category_id]).posts
    elsif params[:q]
      search_term = params[:q]
      @posts = Post.where("title LIKE ?", "%#{search_term}%")
    else
      @posts = Post.all
    end

    if params[:location_id] && params[:p]
      search_term = params[:p]
      posts = Location.find(params[:location_id]).posts
      @posts = posts.where("title LIKE ?", "%#{search_term}%")
    elsif params[:location_id]
      @posts = Category.find(params[:location_id]).posts
    elsif params[:p]
      search_term = params[:p]
      @posts = Post.where("title LIKE ?", "%#{search_term}%")
    else
      @posts = Post.all
    end
    
  end

  def show
    
  end


  def new
    @post = current_user.posts.build
  end


  def create
    if post_params[:location_id] == '7'
      if Location.exists?(:city => params[:location])
        location = Location.find_by(city: params[:location])
      else
        location = Location.new
        location.city = params[:location]
        location.normal = false
        location.save
      end
      
      data = Hash.new
      data[:category_id] = post_params[:category_id]
      data[:title] = post_params[:title]
      data[:description] = post_params[:description]
      data[:experience] = post_params[:experience]
      data[:location_id] = location.id
      data[:years_experience] = post_params[:years_experience]
      data[:price] = post_params[:price]
      
      @post = current_user.posts.build(data)
    else
      @post = current_user.posts.build(post_params)
    end

    if @post.save
      redirect_to @post, notice: "Successfuly create new Post"
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    data = Hash.new
    data[:category_id] = post_params[:category_id]
    data[:title] = post_params[:title]
    data[:description] = post_params[:description]
    data[:experience] = post_params[:experience]
    data[:years_experience] = post_params[:years_experience]
    data[:price] = post_params[:price]

    if post_params[:location_id] == '7'
      if Location.exists?(:city => params[:location])
        location = Location.find_by(city: params[:location])
      else
        location = Location.new
        location.city = params[:location]
        location.normal = false
        location.save
      end
      data[:location_id] = location.id
    else
      data[:location_id] = post_params[:location_id]
    end

    if @post.update(data)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end

    def all_categories
      @categories = Category.all
    end

    def locations
      @normal_locations = Location.where(:normal => true)
      gon.additional_locations = Location.where(:normal => false)
      @additional_locations = Location.all

      @locations = Location.all
    end

    def post_params
      params.require(:post).permit(:title, :description, :experience, :years_experience, :price, :category_id, :image, :location_id, :location)
    end
end
