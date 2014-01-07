module Schemes
  class BaseController < ApplicationController

    private

    def scheme_id
      params[:scheme_id]
    end
    helper_method :scheme_id
  end
end
