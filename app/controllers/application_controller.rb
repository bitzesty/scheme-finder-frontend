class ApplicationController < ActionController::Base
  SUPPORTED_AUDIENCES = %w(businesses teachers)

  protect_from_forgery with: :exception

  respond_to :html

  def url_options
    if current_audience
      { current_audience: current_audience }.merge(super || {})
    else
      super
    end
  end

  private
  def current_audience
    audience = params[:current_audience]
    if audience && SUPPORTED_AUDIENCES.include?(audience.to_s)
      audience
    else
      SUPPORTED_AUDIENCES.first
    end
  end
  helper_method :current_audience
end
