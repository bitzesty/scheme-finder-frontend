class ApplicationController < ActionController::Base
  SUPPORTED_AUDIENCES = %w(businesses teachers)

  protect_from_forgery with: :exception

  respond_to :html

  def default_url_options(options={})
    { current_audience: current_audience }
  end

  private
  def current_audience
    audience = params[:current_audience]
    if audience && SUPPORTED_AUDIENCES.include?(audience.to_s)
      audience.to_s
    else
      SUPPORTED_AUDIENCES.first
    end
  end
  helper_method :current_audience
end
