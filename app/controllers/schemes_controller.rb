class SchemesController < ApplicationController
  def create
    @scheme = Scheme.new(scheme_params)

    if @scheme.save
      flash.notice = 'Scheme submitted for approval'
      location = root_with_audience_url
    else
      flash.alert = 'An issue occured on scheme submission, please check form errors'
      location = new_scheme_url
    end

    respond_with(@scheme, location: location)
  end

  def new
    @scheme = Scheme.new
  end

  def index
    @search = SchemeSearch.new(search_params)
    @search_results = @search.results
    @total_schemes = @search_results.total_count
    @schemes = @search_results.for_kaminari
    @back_link = root_url[/[^\?]+/]
    session[:feedback_path] = root_with_audience_path(current_audience: params[:current_audience], current_agent: "")
  end

  def search
    search_results = SchemeSearch.new(search_params).results

    render partial: "results",
           locals: {
             total_schemes: search_results.total_count,
             schemes: search_results.for_kaminari,
           }
  end

  def mobile_search
    search_results = SchemeSearch.new(search_params).results
    @total_schemes = search_results.total_count
    @schemes = search_results.for_kaminari
    @back_link = root_with_audience_path(current_audience: params[:current_audience], current_agent: "mobile")
    session[:mobile_search_path] = request.env['REQUEST_URI']
    session[:feedback_path] = session[:mobile_search_path]
  end

  private

  def search_params
    result = (params[:search] || {}).merge(params.slice(:page, :per_page))
    if current_audience
      result[:audiences] = [current_audience]
    else
      # nothing
    end

    result
  end
  helper_method :search_params

  def scheme_params
    params.require(:scheme).permit(
      :had_direct_interactions,  :logo,
      :contact_name, :contact_email, :contact_phone,
      :name, :website, :description,
      location_ids: [],
      sector_ids: [],
      audience_ids: [],
      activity_ids: [],
      company_size_ids: [],
      age_range_ids: []
    )
  end
end
