class Admin::MembersController < Admin::BaseController
  
  def search
    member = Account.find_by(name: params[:name])
    redirect_to admin_member_url(member)
  end

  def show
    @account = Account.find(params[:id])
  end
end
