# frozen_string_literal: true

class AddRegularUserToProject < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :regular_user, null: false, foreign_key: true
  end
end
