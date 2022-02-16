# frozen_string_literal: true

class ProposalsController < ApplicationController
  def index
    @proposals = Proposal.where(freelancer_user: current_freelancer_user)
  end

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
      MailDeliveryJob.perform_later(@proposal.id)
      redirect_to @proposal, notice: 'Proposta realizada com sucesso!'
    else
      render :new
    end
  end

  def accept
    @proposal = Proposal.find(params[:id])
    @proposal.accepted!
    redirect_to @proposal.project
  end

  def reject
    @proposal = Proposal.find(params[:id])
    @proposal.rejected!
    redirect_to @proposal.project
  end

  private

  def proposal_params
    params.require(:proposal).permit(:project_id, :reason, :value, :available_time, :expected_end)
  end
end
