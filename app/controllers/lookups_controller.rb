class LookupsController < ApplicationController
  respond_to :html, :json

  # def index
  #   respond_to do |format|
  #     if params[:term]
  #       @projects = Project.search_by_full_name(params[:term]).with_pg_search_highlight
  #     else
  #       @projects = Project.all
  #     end
  #     format.json { render json: @projects.to_json }
  #     format.html
  #   end
  # end

  def index
    respond_to do |format|
      if params[:term]
        @projects = PgSearch.multisearch(params[:term])
      end
      format.json { render json: @projects.to_json }
      format.html
    end
  end

  private

  def set_project
    @project = current_account.projects.find_by(params[:project_id])
  end
  helper_method :set_project

end
