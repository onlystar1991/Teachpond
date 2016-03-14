class RequestsController < ApplicationController
  before_action :find_request, only: [:show, :edit, :update, :destroy]
  before_action :all_categories, only: [:index, :new]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :locations

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

    data = Hash.new
    data[:category_id] = request_params[:category_id]
    data[:title] = request_params[:title]
    data[:description] = request_params[:description]
    data[:experience] = request_params[:experience]
    
    data[:years_experience] = request_params[:years_experience]
    data[:price] = request_params[:price]

    if request_params[:location_id] == '7'
      if Location.exists?(:city => params[:location])
        location = Location.find_by(city: params[:location])
        data[:location_id] = location.id
      else
        location = Location.new
        location.city = params[:location]
        location.normal = false
        location.save

        _location = Location.find_by(city: params[:location])
        data[:location_id] = _location.id
      end
      @request = current_user.requests.build(data)
    else
      @request = current_user.requests.build(request_params)
    end

    if @request.save
      redirect_to @request, notice: "Successfuly create new Request"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    data = Hash.new
    data[:category_id] = request_params[:category_id]
    data[:title] = request_params[:title]
    data[:description] = request_params[:description]
    data[:experience] = request_params[:experience]
    data[:years_experience] = request_params[:years_experience]
    data[:price] = request_params[:price]

    if request_params[:location_id] == '7'
      if Location.exists?(:city => params[:location])
        location = Location.find_by(city: params[:location])
        data[:location_id] = location.id
      else
        location = Location.new
        location.city = params[:location]
        location.normal = false
        location.save

        _location = Location.find_by(city: params[:location])
        data[:location_id] = _location.id
      end
    else
      data[:location_id] = request_params[:location_id];
    end

    if @request.update(data)
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
      params.require(:request).permit(:title, :description, :category_id, :price, :location_id)
    end

    def locations
      @normal_locations = Location.where(:normal => true)
      gon.additional_locations = Location.where(:normal => false)
      @additional_locations = Location.all

      @locations = Location.all
    end
    
end
