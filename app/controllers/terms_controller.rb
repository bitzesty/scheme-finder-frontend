class TermsController < ApplicationController
  def create
    session[:accepted_terms] = params[:accept] == "1"
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def cookies
    session[:accepted_cookies] = true
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
