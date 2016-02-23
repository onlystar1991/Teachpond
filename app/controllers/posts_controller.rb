class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :all_categories, only: [:index, :new]
  before_action :authenticate_user!, except: [:index, :show]


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
  end

  def show
  end


  def new
    @post = current_user.posts.build
  end


  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Successfuly create new Post"
    elsee
      render 'nw'
    end

  end

  def edit
  end


  def update
    if @post.update(post_params)
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


    def post_params
      params.require(:post).permit(:title, :description, :experience, :years_experience, :price, :category_id)
    end

end
