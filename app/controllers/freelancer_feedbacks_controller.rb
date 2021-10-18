class FreelancerFeedbacksController < ApplicationController
  def show
    @freelancer_feedback = FreelancerFeedback.find(params[:id])
  end

  def create
    @freelancer_feedback = FreelancerFeedback.new(freelancer_feedback_params)
    @freelancer_feedback.proposal = Proposal.find(params[:proposal_id])
    @freelancer_feedback.save
    redirect_to @freelancer_feedback, notice: 'Feedback enviado com sucesso!'
  end

  private

  def freelancer_feedback_params
    params.require(:freelancer_feedback).permit(:feedback)
  end
end