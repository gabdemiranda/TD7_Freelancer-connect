class AddStatusToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :status, :integer, default: 5
  end
end
