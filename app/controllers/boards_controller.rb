class BoardsController < BaseController
  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    if @board.save
      flash[:notice] = "You've posted on the board."
      redirect_to [current_account, @project]
    else
      flash.now[:alert] = "Something's wrong."
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  private

  def board_params
    params.require(:board).permit(:note, :user_id)
  end

end
