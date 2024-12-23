class Vacancy < ApplicationRecord
  belongs_to :employer, class_name: "Employer", foreign_key: :user_id
  
  validates :title, presence: true
  validates :description, presence: true
  validates :skills_required, presence: true
  validates :salary_min, presence: true, numericality: { greater_than: 0 }
  validates :salary_max, presence: true, numericality: { greater_than: :salary_min }
  validates :contact, presence: true
  validates :is_active, inclusion: { in: [true, false] }
end
