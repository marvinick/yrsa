class LookupsController < BaseController
  respond_to :html, :json

  def index
    respond_to do |format|
      format.html
      format.js { @pg_search_documents = PgSearch.multisearch( params[:query]) }
    end
  end

  private

  def set_project
    @project = current_account.projects.find_by(params[:project_id])
  end
  helper_method :set_project

end
