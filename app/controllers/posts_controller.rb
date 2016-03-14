class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :all_categories, only: [:index, :new]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :locations

  def index
    if params[:category_id]
      @posts = Category.find(params[:category_id]).posts
    end
    if params[:location_id]
      @posts = Category.find(params[:location_id]).posts
    end
  end

  def show
    puts "-----------------"
    puts @post.inspect
  end

  def new
    @post = current_user.posts.build
  end


  def create
    
    data = Hash.new
    data[:category_id] = post_params[:category_id]
    data[:title] = post_params[:title]
    data[:description] = post_params[:description]
    data[:experience] = post_params[:experience]
    data[:years_experience] = post_params[:years_experience]
    data[:price] = post_params[:price]
    data[:url] = post_params[:url]

    if post_params[:location_id] == '7'
      if Location.exists?(:city => params[:location])
        location = Location.find_by(city: params[:location])
      else
        location = Location.new
        location.city = params[:location]
        location.normal = false
        location.save

        _location = Location.find_by(city: params[:location])

        data[:location_id] = _location.id
      end
      @post = current_user.posts.build(data)
    else
      data[:location_id] = post_params[:location_id]
      @post = current_user.posts.build(data)
    end
    
    puts "-----------------Save-----------";
    puts @post.inspect
    if @post.save
      redirect_to @post, notice: "Successfuly create new Post"
    else
      puts "-------Error----------"
      puts @post.errors.messages
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
    data[:url] = post_params[:url]

    if post_params[:location_id] == '7'
      if Location.exists?(:city => params[:location])
        location = Location.find_by(city: params[:location])
      else
        location = Location.new
        location.city = params[:location]
        location.normal = false
        location.save

        _location = Location.find_by(city: params[:location])

        data[:location_id] = _location.id
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
      params.require(:post).permit(:title, :description, :experience, :years_experience, :price, :category_id, :image, :location_id, :location, :url)
    end
end
