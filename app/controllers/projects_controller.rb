class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @freelancer_feedback = FreelancerFeedback.new
  end

  def my_projects
    @projects = current_regular_user.projects
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.regular_user = current_regular_user
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def close
    @project = Project.find(params[:id])
    @project.closed!
    redirect_to @project
  end

  private

  def project_params 
    params.require(:project).permit(:title, :description, :skills, :value, :end_date, :work_style )
  end

end