class LookupsController < BaseController
  def search
    @items = if params[:term]
      set_project.items.where('name ILIKE ?', "%#{params[:term]}%")
      redirect_to account_lookups_path(current_account)
    else
      set_project.items.all
    end
  end

  def index
    set_project.items.where('name ILIKE ?', "%#{params[:term]}%")
  end

  private

  def set_project
    current_account.projects.find(params[:id])
  end
end
