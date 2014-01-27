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
    end

    def index
      @feedbacks = Feedback.all(scheme_id: scheme_id)
      @average_score = Feedback.average_score_for @feedbacks
    end

    private

    def feedback_params
      params.require(:feedback).permit(
        :score, :description
      )
    end
  end
end
