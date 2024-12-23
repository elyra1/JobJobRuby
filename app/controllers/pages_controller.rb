class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.worker?
      @vacancies = Vacancy.where(is_active: true)
      @vacancies = search_records(@vacancies, params[:search]) if params[:search].present?
      @vacancies = @vacancies.page(params[:page]).per(12)
    elsif current_user.employer?
      @resumes = Resume.where(is_active: true)
      @resumes = search_records(@resumes, params[:search]) if params[:search].present?
      @resumes = @resumes.page(params[:page]).per(12)
    end
  end

  def my_list
    if current_user.worker?
      @resumes = current_user.resumes.order(created_at: :desc).page(params[:page]).per(9)
    elsif current_user.employer?
      @vacancies = current_user.vacancies.order(created_at: :desc).page(params[:page]).per(9)
    end
  end

  private

  def search_records(relation, search_term)
    relation.where("LOWER(title) LIKE LOWER(:search) OR LOWER(description) LIKE LOWER(:search)",
                   search: "%#{search_term}%")
  end
end