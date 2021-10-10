class ProjectsController < ApplicationController
  def show
    id = params[:id]
    @project = Project.find(id)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def project_params 
    params.require(:project).permit(:title, :description, :skills, :value, :end_date, :work_style )
  end
end