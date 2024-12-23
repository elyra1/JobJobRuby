class VacanciesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_employer, only: [:new, :create, :edit, :update, :destroy, :toggle_active]
  before_action :set_vacancy, only: [:show, :edit, :update, :destroy, :toggle_active]
  before_action :ensure_owner, only: [:edit, :update, :destroy, :toggle_active]

  def show
    unless @vacancy.employer == current_user
      if !current_user.worker? || !@vacancy.is_active
        redirect_to root_path, alert: 'Access denied.'
      end
    end
  end

  def new
    @vacancy = current_user.vacancies.build
  end

  def create
    @vacancy = current_user.vacancies.build(vacancy_params)
    if @vacancy.save
      redirect_to my_list_path, notice: 'Vacancy was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @vacancy.update(vacancy_params)
      redirect_to my_list_path, notice: 'Vacancy was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vacancy.destroy
    redirect_to my_list_path, notice: 'Vacancy was successfully deleted.'
  end

  def toggle_active
    @vacancy.update(is_active: !@vacancy.is_active)
    redirect_to request.referer || my_list_path, notice: 'Vacancy status was updated.'
  end

  private

  def set_vacancy
    @vacancy = Vacancy.find(params[:id])
  end

  def vacancy_params
    params.require(:vacancy).permit(:title, :description, :skills_required,
                                  :salary_min, :salary_max, :is_active, :contact, :currency)
  end

  def ensure_employer
    unless current_user.employer?
      redirect_to root_path, alert: 'Access denied.'
    end
  end

  def ensure_owner
    unless @vacancy.employer == current_user
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end 