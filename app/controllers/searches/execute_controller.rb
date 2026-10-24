class Searches::ExecuteController < ApplicationController
  def new
    @search = Search.new
  end

  def show
    @search = Current.user.searches.new(search_params.compact_blank)

    execute_search if @search.query.present?
  end

  def existing
    @search = Current.user.searches.find(params[:id])
    execute_search
  end

  private

  def execute_search
    result = EbayService.search(@search)
    @total = result[:total]
    @results = result[:results]
  end

  def search_params
    params.expect(search: [ :name, :notes, :query, :category_ids, :buying_options, :conditions, :minimum, :maximum, :search_in_description ])
  end
end
