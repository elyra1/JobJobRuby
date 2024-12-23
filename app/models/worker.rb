class Worker < User
  has_many :resumes, foreign_key: :user_id
  
  validates :birthdate, presence: true
  validates :name, presence: true
  validate :birthdate_cannot_be_in_future
  validate :must_be_at_least_16


  def age
    return nil unless birthdate
    now = Time.current.to_date
    age = now.year - birthdate.year
    age -= 1 if now.month < birthdate.month || (now.month == birthdate.month && now.day < birthdate.day)
    age
  end

  private

  def birthdate_cannot_be_in_future
    if birthdate.present? && birthdate > Date.today
      errors.add(:birthdate, "can't be in the future")
    end
  end

  def must_be_at_least_16
    if birthdate.present? && age < 16
      errors.add(:birthdate, "must be at least 16 years old")
    end
  end
end
