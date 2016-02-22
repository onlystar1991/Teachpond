class StaticPagesController < ApplicationController

  def home
    @posts = Post.all
    @requests = Request.all
    @categories = Category.all

    @home_page = true
  end

  def about
  end

  def contact
  end

  def how_it_works
  end

  def add_new
    if current_user.profile.first_name.blank? || current_user.profile.last_name.blank? || current_user.profile.city.blank?
      redirect_to edit_user_profile_path(current_user.id, current_user.profile.id), :flash => { :error => "You need to fill your name and location before you can create a post" }
    end
  end

end
