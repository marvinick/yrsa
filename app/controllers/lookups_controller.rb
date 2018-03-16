class LookupsController < ApplicationController
  respond_to :html, :json

  def index
    if params[:term]
      @pg_search_documents = PgSearch.multisearch(params[:term]).where(:searchable_id => project_ids).or(PgSearch.multisearch(params[:term]).where(:searchable_id => item_ids)).or(PgSearch.multisearch(params[:term]).where(:searchable_id => account_ids))
    end
  end

  private

  def account_ids
    all_accounts = []
    current_user.all_accounts.each do |account|
      all_accounts << account.id
    end
    all_accounts
  end

  def project_ids
    all_projects = []
    current_user.all_accounts.each do |account|
      account.projects.each do |project|
        all_projects << project.id
      end
    end
    all_projects
  end

  def item_ids
    all_items = []
    current_user.all_accounts.each do |account|
      account.projects.each do |project|
        project.items.each do |item|
          all_items << item.id
        end
      end
    end
    all_items
  end

end
