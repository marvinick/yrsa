class LookupsController < BaseController

  def index
    respond_to do |format|
      @pg_search_documents = PgSearch.multisearch( params[:query])
      format.json
      format.html
    end
  end

  private

  def set_project
    @project = current_account.projects.find_by(params[:project_id])
  end
  helper_method :set_project

end
