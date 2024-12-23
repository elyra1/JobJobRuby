class UpdateDefaultCurrencyInVacanciesAndResumes < ActiveRecord::Migration[8.0]
  def up
    # Обновляем значения по умолчанию для существующих записей
    execute "UPDATE vacancies SET currency = 'RUB' WHERE currency IS NULL"
    execute "UPDATE resumes SET currency = 'RUB' WHERE currency IS NULL"
    
    # Изменяем значение по умолчанию и делаем поле not null
    change_column_default :vacancies, :currency, 'RUB'
    change_column_null :vacancies, :currency, false
    
    change_column_default :resumes, :currency, 'RUB'
    change_column_null :resumes, :currency, false
  end

  def down
    change_column_null :vacancies, :currency, true
    change_column_default :vacancies, :currency, nil
    
    change_column_null :resumes, :currency, true
    change_column_default :resumes, :currency, nil
  end
end