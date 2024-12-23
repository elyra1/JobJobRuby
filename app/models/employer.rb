class Employer < User
  has_many :vacancies, foreign_key: :user_id
  validates :name, presence: true
end
