class BoardsController < BaseController
  before_action :set_project
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize_owner!
  respond_to :html, :json

  def new
    @board = @project.boards.new
  end

  def create
    @board = Board.new(board_params)
    @board.project_id = @project.id
    @board.user_id = current_user.id
    if @board.save
      redirect_to account_project_boards_path(current_account, @project, @boards)
      flash[:notice] =  "Board is created."
      # respond_to do |f|
      #   f.html { redirect_to [current_account, @project, @boards], notice: "Board is created." }
      #   f.json { render :show, status: :created, location: @board }
      # end
    else
      flash.now[:alert] = "Something is wrong."
      redirect_to account_project_boards_path(current_account, @project, @boards)
    end
  end

  def index
    @boards = @project.boards.all.order("created_at desc")
    @board_weeks = @boards.group_by { |board| board.created_at.beginning_of_week(:sunday) }
  end

  def show; end

  def edit; end

  def update
    if @board.update_attributes(board_params)
      flash[:notice] = "Board is updated."
      redirect_to account_project_boards_path(current_account, @project, @boards)
    else
      flash.now[:alert] = "Board is not saved."
    end
  end

  def destroy
    @board.destroy
    flash[:notice] = "You have deleted the note."
    redirect_to account_project_boards_path(current_account, @project, @boards)
  end

  private

  def set_board
    @board = @project.boards.find(params[:id])
  end

  def set_project
    @project = current_account.projects.find(params[:project_id])
  end

  def board_params
    params.require(:board).permit(:note, :respond, :user_id, :project_id, :photo)
  end

end
