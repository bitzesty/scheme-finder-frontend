module SchemesHelper
  def had_direct_interactions_label
    if businesses_audience?
      "Have you engaged with schools before?"
    else
      "Have you engaged with businesses before?"
    end
  end

  def age_range_label
    if businesses_audience?
      "What age range would you prefer to engage with?"
    else
      "What age range are your students?"
    end
  end

  def search_params_list(search_params)
    search_params.values
                 .flatten
                 .compact
                 .map(&:titleize)
                 .reject(&:blank?)
                 .reject{ |value| %w(0 1).include?(value) }
  end
end
