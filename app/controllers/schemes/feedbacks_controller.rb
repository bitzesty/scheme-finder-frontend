module Schemes
  class FeedbacksController < Schemes::BaseController
    def create
      @feedback = Feedback.new(feedback_params)

      if @feedback.save(scheme_id)
        redirect_to scheme_feedbacks_url(scheme_id),
                    notice: 'Feedback submitted for approval'
      else
        flash.alert = 'An issue occured on feedback submission, please check form errors'
        render :new
      end
    end

    def new
      @feedback = Feedback.new
      @back_link = session[:feedback_path]
    end

    def index
      @feedbacks = Feedback.all(scheme_id: scheme_id)
      @average_score = Feedback.average_score_for @feedbacks
      if session[:mobile_search_path]
        @back_link = session[:mobile_search_path]
      else
        @back_link = root_with_audience_path(current_audience: params[:current_audience], current_agent: "mobile")
      end
      session[:feedback_path] = scheme_feedbacks_path(scheme)
    end

    private

    def feedback_params
      params.require(:feedback).permit(
        :score, :description
      )
    end
  end
end
