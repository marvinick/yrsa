class LookupsController < BaseController

  def index
    @lookups = if params[:term]
      current_account.projects.where('title ILIKE ?', "%#{params[:term]}%")
    else
      current_account.projects.all
    end
  end

  private

  def search_params
    params.permit(:title).delete_if {|key, value| value.blank? }
  end

  def set_project
    current_account.projects.find_by(params[:project_id])
  end
  helper_method :set_project

end
