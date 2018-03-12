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
    project_ids = current_account.projects.all
    item_ids = set_project.items.all
    respond_to do |format|
      if params[:term]
        @pg_search_documents = PgSearch.multisearch(params[:term]).where()
      end
      format.json { @pg_search_documents }
      format.html
    end
  end

  private

  def set_project
    current_account.projects.find_by slug: params[:project_id]
  end
end
