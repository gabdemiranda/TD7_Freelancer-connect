class Profile < ApplicationRecord
  belongs_to :freelancer_user
  validates :fullname, :socialname, :birthdate,
  :education, :experience, :description, presence: true
end
