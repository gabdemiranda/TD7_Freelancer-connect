# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :fullname
      t.string :socialname
      t.date :birthdate
      t.string :education
      t.string :description
      t.string :experience

      t.timestamps
    end
  end
end
