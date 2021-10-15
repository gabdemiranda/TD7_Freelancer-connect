class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
    @project = Project.find(params[:project_id])
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.freelancer_user = current_freelancer_user
    @proposal.project = Project.find(params[:project_id])
    if @proposal.save
      redirect_to @proposal, notice: 'Proposta realizada com sucesso!'
    else
      render :new
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:project_id, :reason, :value, :available_time, :expected_end)
  end
end
