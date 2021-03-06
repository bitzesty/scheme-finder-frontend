class ApplicationController < ActionController::Base
  before_action :maintenance_page
  before_action :set_cache_headers

  protect_from_forgery with: :exception

  respond_to :html

  def default_url_options(options={})
    {
      current_agent: current_agent,
      current_audience: current_audience,
    }
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

  def current_agent
    params[:current_agent].to_s
  end
  helper_method :current_agent

  def mobile_device?
    current_agent == "mobile"
  end
  helper_method :mobile_device?

  def maintenance_page
    if SchemeFinderFrontend.show_maintenance
      redirect_to maintenance_page_path
    end
  end

  def set_cache_headers
    expires_in 1.hour, public: true
  end
end
