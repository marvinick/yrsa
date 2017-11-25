class HomeController < ApplicationController
  def home
    @projects = if params[:term]
      Project.where('title ILIKE ?', "%#{params[:term]}%")
    else
      Project.all
    end
  end
end
