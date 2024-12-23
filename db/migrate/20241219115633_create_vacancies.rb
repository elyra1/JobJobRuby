class CreateVacancies < ActiveRecord::Migration[8.0]
  def change
    create_table :vacancies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.text :skills_required
      t.decimal :salary_min
      t.decimal :salary_max
      t.boolean :is_active
      t.text :contact

      t.timestamps
    end
  end
end
