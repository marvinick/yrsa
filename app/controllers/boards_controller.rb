class BoardsController < BaseController
  before_action :set_project
  before_action :set_board, only: [:edit, :update, :destroy]

  def new
    @project = current_account.projects.find(params[:project_id])
    @board = @project.boards.build
  end

  def create
    @board = Board.new(board_params)
    @board.project_id = set_project.id
    @board.user_id = current_user.id
    if @board.save
      flash[:notice] = "You've posted on the board."
    else
      flash.now[:alert] = "Something's wrong."
    end
  end

  def edit; end

  def update
    if @board.update_attributes(board_params)
      flash[:notice] = "Board is updated."
    else
      flash.now[:alert] = "Board is not saved."
    end
  end

  def destroy
    @board.destroy
    flash[:notice] = "You have deleted the note."
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def set_project
    Project.find(params[:project_id])
  end
  helper_method :set_project

  def board_params
    params.require(:board).permit(:note, :user_id, :project_id)
  end

end
