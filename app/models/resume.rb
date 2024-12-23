class Resume < ApplicationRecord
  belongs_to :worker, class_name: "Worker", foreign_key: :user_id
  
  validates :title, presence: true
  validates :description, presence: true
  validates :skills, presence: true
  validates :experience, presence: true
  validates :education, presence: true
  validates :salary_expectation, presence: true, numericality: { greater_than: 0 }
  validates :contact, presence: true
  validates :is_active, inclusion: { in: [true, false] }
end
