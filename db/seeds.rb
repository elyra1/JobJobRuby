# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Создаем работников
10.times do |i|
  worker = Worker.create!(
    email: "worker#{i}@example.com",
    password: "password",
    password_confirmation: "password",
    name: Faker::Name.name,
    birthdate: Faker::Date.birthday,
  )

  # Создаем резюме для каждого работника
  rand(1..6).times do
    Resume.create!(
      user_id: worker.id,
      title: Faker::Job.title,
      description: Faker::Lorem.paragraph(sentence_count: 3),
      skills: Faker::Job.key_skill,
      experience: Faker::Lorem.paragraph(sentence_count: 2),
      education: "#{Faker::Educator.degree} in #{Faker::Educator.subject}",
      salary_expectation: rand(30000..120000),
      currency: 'RUB',
      contact: Faker::PhoneNumber.phone_number,
      is_active: [true, false].sample
    )
  end
end

# Создаем работодателей
10.times do |i|
  employer = Employer.create!(
    email: "employer#{i}@example.com",
    password: "password",
    password_confirmation: "password",
    name: Faker::Company.name
  )

  # Создаем вакансии для каждого работодателя
  rand(1..6).times do
    salary_min = rand(30000..80000)
    Vacancy.create!(
      user_id: employer.id,
      title: Faker::Job.title,
      description: Faker::Lorem.paragraph(sentence_count: 3),
      skills_required: Faker::Job.key_skills,
      salary_min: salary_min,
      salary_max: salary_min + rand(10000..40000),
      currency: 'RUB',
      contact: "#{Faker::PhoneNumber.phone_number}, #{Faker::Internet.email}",
      is_active: [true, false].sample
    )
  end
end
