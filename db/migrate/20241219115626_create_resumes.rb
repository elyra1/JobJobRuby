class CreateResumes < ActiveRecord::Migration[8.0]
  def change
    create_table :resumes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.text :skills
      t.text :experience
      t.text :education
      t.decimal :salary_expectation
      t.boolean :is_active
      t.text :contact

      t.timestamps
    end
  end
end
