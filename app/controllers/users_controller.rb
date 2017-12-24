class UsersController < BaseController
  before_action :authorize_owner!

  def index
    @users = current_account.users.all
    @invitations = current_account.invitations.all 
  end

  def destroy
    user = User.find(params[:id])
    current_account.users.delete(user)
    flash[:notice] = "#{user.email} has been removed from this account."
    redirect_to account_users_path(current_account, @users)
  end
end
