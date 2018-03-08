class LookupsController < ApplicationController
  respond_to :html, :json

  def index
    respond_to do |format|
      if params[:term]
        @pg_search_documents = Item.search_by_full_name(params[:term]).with_pg_search_highlight
      else
        @pg_search_documents = Item.all
      end
      format.json {  @pg_search_documents  }
      format.html
    end
  end

  # def index
  #   respond_to do |format|
  #
  #     @pg_search_documents = PgSearch.multisearch(params[:term])
  #
  #     format.json { render json: @pg_search_documents }
  #     format.html
  #
  #   end
  #
  # end
end
