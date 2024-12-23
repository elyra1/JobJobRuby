class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_worker, only: [:new, :create, :edit, :update, :destroy, :toggle_active]
  before_action :set_resume, only: [:show, :edit, :update, :destroy, :toggle_active]
  before_action :ensure_owner, only: [:edit, :update, :destroy, :toggle_active]

  def show
    unless @resume.worker == current_user
      if !current_user.employer? || !@resume.is_active
        redirect_to root_path, alert: 'Access denied.'
      end
    end
  end

  def new
    @resume = current_user.resumes.build
  end

  def create
    @resume = current_user.resumes.build(resume_params)
    if @resume.save
      redirect_to my_list_path, notice: 'Resume was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @resume.update(resume_params)
      redirect_to my_list_path, notice: 'Resume was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @resume.destroy
    redirect_to my_list_path, notice: 'Resume was successfully deleted.'
  end

  def toggle_active
    @resume.update(is_active: !@resume.is_active)
    redirect_to request.referer || my_list_path, notice: 'Resume status was updated.'
  end

  private

  def set_resume
    @resume = Resume.find(params[:id])
  end

  def resume_params
    params.require(:resume).permit(:title, :description, :skills, :experience, 
                                 :education, :salary_expectation, :is_active, :contact)
  end

  def ensure_worker
    unless current_user.worker?
      redirect_to root_path, alert: 'Access denied.'
    end
  end

  def ensure_owner
    unless @resume.worker == current_user
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end
