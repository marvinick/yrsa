class LookupsController < BaseController

  def index
    @pg_search_documents = PgSearch.multisearch( params[:query] )
  end

  private

  def set_project
    current_account.projects.find_by(params[:project_id])
  end
  helper_method :set_project

end
