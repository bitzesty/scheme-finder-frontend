class SchemesController < ApplicationController
  def create
    @scheme = Scheme.new(scheme_params)

    if @scheme.save
      flash.notice = 'Scheme submitted for approval'
    else
      flash.alert = 'An issue occured on scheme submission, please check form errors'
    end

    respond_with(@scheme, location: new_scheme_url)
  end

  def new
    @scheme = Scheme.new
  end

  def index
    @search = SchemeSearch.new(search_params)
    if params[:search]
      @search_conducted = true
      @search_results = @search.results
      @total_schemes = @search_results.total_count
      @schemes = @search_results.for_kaminari
    end
  end

  private

  def search_params
    (params[:search] || {}).merge(params.slice(:page, :per_page))
  end

  def scheme_params
    params.require(:scheme).permit(
      :had_direct_interactions,  :logo,
      :contact_name, :contact_email, :contact_phone,
      :name, :website, :description,
      location_ids: [],
      sector_ids: [],
      commitment_length_ids: [],
      activity_ids: [],
      company_size_ids: [],
      age_range_ids: []
    )
  end
end
