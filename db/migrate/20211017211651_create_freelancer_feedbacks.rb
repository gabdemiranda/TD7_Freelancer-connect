# frozen_string_literal: true

class CreateFreelancerFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :freelancer_feedbacks do |t|
      t.string :feedback

      t.timestamps
    end
  end
end
