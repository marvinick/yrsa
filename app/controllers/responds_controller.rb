class RespondsController < BaseController
  before_action :set_board
  respond :html, :json

  def new
  end

  def create
  end

  private

  def set_board
    @board = set_project.boards.find(params[:id])
  end

  def set_project
    current_account.projects.find_by slug: params[:project_id]
  end

end
