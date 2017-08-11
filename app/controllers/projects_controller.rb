class ProjectsController < ApplicationController
  before_action :set_account
  before_action :set_project, except: [:index, :create, :new]

  def index
    @projects = Project.all
  end

  def new
    @project = @account.projects.build(account_id: params[:account_id])
  end

  def create
    
  private
  def set_account
    @account = Account.find(params[:account_id])
  end

  def set_project
    @project = @account.projects.find(params[:id])
  end
end
