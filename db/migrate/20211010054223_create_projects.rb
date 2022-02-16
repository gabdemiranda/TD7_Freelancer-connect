# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :skills
      t.decimal :value
      t.date :end_date
      t.string :work_style

      t.timestamps
    end
  end
end
