class RequestsController < ApplicationController
  before_action :find_request, only: [:show, :edit, :update, :destroy]
  before_action :all_categories, only: [:index, :new]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:category_id] && params[:q]
      search_term = params[:q]
      requests = Category.find(params[:category_id]).requests
      @requests = requests.where("title LIKE ?", "%#{search_term}%")
    elsif params[:category_id]
      @requests = Category.find(params[:category_id]).requests
    elsif params[:q]
      search_term = params[:q]
      @requests = Request.where("title LIKE ?", "%#{search_term}%")
    else
      @requests = Request.all
    end

    if params[:location_id] && params[:q]
      search_term = params[:q]
      requests = Location.find(params[:location_id]).requests
      @requests = requests.where("title LIKE ?", "%#{search_term}%")
    elsif params[:location_id]
      @requests = Category.find(params[:location_id]).requests
    elsif params[:q]
      search_term = params[:q]
      @requests = Request.where("title LIKE ?", "%#{search_term}%")
    else
      @requests = Request.all
    end

    @locations = Location.all
  end

  def show
  end

  def new
    @request = current_user.requests.build
  end

  def create
    @request = current_user.requests.build(request_params)

    if @request.save
      redirect_to @request, notice: "Successfuly create new Request"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @request.update(request_params)
      redirect_to @request
    else
      render 'edit'
    end
  end

  def destroy
    @request.destroy
    redirect_to root_path
  end

  private

    def find_request
      @request = Request.find(params[:id])
    end

    def all_categories
      @categories = Category.all
    end

    def request_params
      params.require(:request).permit(:title, :description, :category_id, :price)
    end

end
