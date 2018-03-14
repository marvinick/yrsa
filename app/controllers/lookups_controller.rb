class LookupsController < ApplicationController
  respond_to :html, :json

  # def index
  #   respond_to do |format|
  #     if params[:term]
  #       @pg_search_documents = Item.search_by_full_name(params[:term]).with_pg_search_highlight
  #     else
  #       @pg_search_documents = Item.all
  #     end
  #     format.json {  @pg_search_documents  }
  #     format.html
  #   end
  # end

  def index
    
    respond_to do |format|
      if params[:term]
        @pg_search_documents = PgSearch.multisearch(params[:term]).where(:searchable_id => project_ids).or(PgSearch.multisearch(params[:term]).where(:searchable_id => item_ids))
      end
      format.json { @pg_search_documents }
      format.html
    end
  end

  private

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

  def set_project
    current_account.projects.find_by slug: params[:project_id]
  end
end
