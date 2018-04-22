class ChallengesController < BaseController
  before_action :set_project
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  respond_to :hmtl, :json

  def index
    @challenges = @project.challenges.all
  end

  def new
    @challenge = @project.challenges.build
  end

  def create
    @challenge = Challenge.new(challenge_params)
    if @challenge.save
      respond_to do |f|
        f.js
      end
      flash[:notice] = "You've submitted a challenge."
    else
      redirect_to "new"
      flash.now[:alert] = "Something's wrong with your message."
    end
  end

  def show; end

  def edit; end

  def update
  end

  private

  def challenge_params
    params.require(:challenge).permit(:name, :description, :due_date)
  end 

  def set_project
    @project = current_account.projects.find_by slug: params[:project_id]
  end
end
