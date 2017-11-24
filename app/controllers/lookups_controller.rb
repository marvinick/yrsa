class LookupsController < ApplicationController

  def index
    @lookups = if params[:term]
      Project.where('title ILIKE ?', "%#{params[:term]}%")
    else
      Project.all
    end

  end

  private

  def set_project
    current_account.projects.find(params[:id])
  end
end
