class BoardsController < BaseController
  before_action :set_project
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_owner!
  respond_to :html, :json

  def new
    @project = current_account.projects.find_by slug: params[:project_id]
    @board = @project.boards.new
  end

  def create
    @board = Board.new(board_params)
    @board.project_id = set_project.id
    @board.user_id = current_user.id
    if @board.save
      respond_to do |format|
        format.js {}
        # flash[:notice] = "You've posted on the board."
      end
    end
  end

  def index
    @board = set_project.boards.new
    @boards = set_project.boards.all.order("created_at desc")
  end

  def show; end

  def edit; end

  def update
    if @board.update_attributes(board_params)
      flash[:notice] = "Board is updated."
      redirect_to account_project_board_path(current_account, set_project, @board)
    else
      flash.now[:alert] = "Board is not saved."
    end
  end

  def destroy
    @board.destroy
    flash[:notice] = "You have deleted the note."
    redirect_to account_project_boards_path(current_account, set_project, @boards)
  end

  private

  def set_board
    @board = set_project.boards.find(params[:id])
  end

  def set_project
    Project.find_by slug: params[:project_id]
  end
  helper_method :set_project

  def board_params
    params.require(:board).permit(:note, :respond, :user_id, :project_id)
  end

end
