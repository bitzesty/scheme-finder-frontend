class SchemesController < ApplicationController
  def create
    @scheme = Scheme.new(scheme_params)

    if @scheme.save
      redirect_to new_scheme_url,
                  notice: "Scheme submitted for administrator approval"
    else
      render :new
    end
  end

  def new
    @scheme = Scheme.new
  end

  private

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
