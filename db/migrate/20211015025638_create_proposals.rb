class CreateProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.string :reason
      t.decimal :value
      t.integer :available_time
      t.date :expected_end
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
