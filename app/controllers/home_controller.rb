class HomeController < ApplicationController

  def index
    @projects = Project.all()
  end

  def search
    @projects = Project.where('title like ? OR description like ? OR skills like ?',
    "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
  end
end