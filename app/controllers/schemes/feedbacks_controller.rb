module Schemes
  class FeedbacksController < Schemes::BaseController
    def create
      @scheme = Scheme.all[params[:scheme_id].to_i-1]
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
      @scheme = Scheme.all[params[:scheme_id].to_i-1]
      @feedback = Feedback.new
    end

    def index
      @scheme = Scheme.all[params[:scheme_id].to_i-1]
      @feedbacks = Feedback.all(scheme_id: scheme_id)

      @average_feedback = 0.0
      @feedbacks.each do |feedback|
        @average_feedback += feedback.score
      end
      @average_feedback = @average_feedback/@feedbacks.count
    end

    private

    def feedback_params
      params.require(:feedback).permit(
        :score, :description
      )
    end
  end
end
