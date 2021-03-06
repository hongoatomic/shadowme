class CreateProfessionals < ActiveRecord::Migration[5.2]
  def change
    create_table :professionals do |t|
      t.references :career, foreign_key: true
      t.references :user, foreign_key: true
      t.string :address
      t.string :location
      t.string :specialty
      t.text :resume
      t.integer :experience_in_years
      t.string :company_logo

      t.timestamps
    end
  end
end
