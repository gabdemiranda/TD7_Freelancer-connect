class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer_user
end
