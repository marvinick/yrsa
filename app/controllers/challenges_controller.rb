class ChallengesController < BaseController
  before_action :set_project
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  respond_to :hmtl, :json

  def index
    @challenges = @project.challenges.order("due_date")
    @challenge_weeks = @challenges.group_by { |challenge| challenge.due_date.beginning_of_week(:sunday) }
  end

  def new
    @challenge = @project.challenges.build
  end

  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.user_id = current_user.id
    if @challenge.save

      flash[:notice] = "You've submitted a challenge."
    else
      redirect_to "new"
      flash.now[:alert] = "Something's wrong with your message."
    end
  end

  def show; end

  def edit; end

  def update
    if @challenge.update_attributes(challenge_params)
      flash[:notice] = "You have updated the challenge."
       redirect_to [current_account, @project, @challenge]
    else
      flash.now[:alert] = "Something's wrong."
      render "edit"
    end
  end

  def destroy
    @challenge.destroy
    flash[:notice] = "You've successfully deleted the challenge."
    redirect_to account_project_challenges_path(current_account, @project, @challenges)
  end

  private

  def challenge_params
    params.require(:challenge).permit(:picture, :name, :description, :due_date, :project_id, :user_id)
  end

  def set_project
    @project = current_account.projects.find_by slug: params[:project_id]
  end

  def set_challenge
    @challenge = @project.challenges.find(params[:id])
  end
end
