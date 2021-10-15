class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer_user

  validates :reason, :value, :available_time, :expected_end, presence: true
end
