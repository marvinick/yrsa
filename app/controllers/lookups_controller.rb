class LookupsController < ApplicationController
  respond_to :html, :json

  # def index
  #   respond_to do |format|
  #     if params[:term]
  #       @projects = Item.search_by_full_name(params[:term]).with_pg_search_highlight
  #     else
  #       @projects = Item.all
  #     end
  #     format.json { render json: @projects.to_json }
  #     format.html
  #   end
  # end

  def index
    respond_to do |format|
      if params[:term]
        @pg_search_documents = PgSearch.multisearch(params[:term])
      end
      format.html
      format.json { render json: @pg_search_documents.to_json }
    end
  end
end
