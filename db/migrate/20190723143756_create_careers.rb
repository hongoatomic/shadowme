class CreateCareers < ActiveRecord::Migration[5.2]
  def change
    create_table :careers do |t|
      t.string :title
      t.text :description
      t.references :category, foreign_key: true
      t.string :image
      t.timestamps
    end
  end
end
