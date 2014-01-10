class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  respond_to :html

  def default_url_options(options={})
    { current_audience: current_audience }
  end

  private
  def current_audience
    audience = params[:current_audience]
    if audience
      audience.to_s
    else
      SchemeFinderFrontend.default_audience
    end
  end
  helper_method :current_audience
end
