class ProjectsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    @pagy, @projects = pagy(Project.all)
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_status
    @project = Project.find(params.expect(:id))
    @project.update!(status: params.expect(:status))
    redirect_to @project, notice: "Project status was successfully updated.", status: :see_other
  end


  def destroy
    @project.destroy!
    redirect_to projects_path, notice: "Project was successfully destroyed.", status: :see_other
  end

  private
    def set_project
      @project = Project.find(params.expect(:id))
    end

    def project_params
      params.expect(project: [ :name, :description, :status, :user_id ])
    end
end
