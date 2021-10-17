class AddStatusToProposal < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :status, :integer, default: 5
  end
end
