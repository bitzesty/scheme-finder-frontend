class SchemesController < ApplicationController
  expose(:scheme, attributes: :scheme_params)

  def create
    if scheme.valid?
      redirect_to new_scheme_url,
                  notice: "Scheme submitted for administrator approval"
    else
      render :new
    end
  end

  def new
  end

  private

  def scheme_params
    params.require(:scheme).permit(
      :had_direct_interactions,  :logo, :logo_cache,
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
