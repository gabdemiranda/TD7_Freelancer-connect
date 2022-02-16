# frozen_string_literal: true

class AddFreelancerUserToProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :profiles, :freelancer_user, null: false, foreign_key: true
  end
end
