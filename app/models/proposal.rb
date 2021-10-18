class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer_user
  has_one :freelancer_freedback

  validates :reason, :value, :available_time, :expected_end, presence: true

  enum status: { pending: 5, accepted: 10, rejected: 20}
end
