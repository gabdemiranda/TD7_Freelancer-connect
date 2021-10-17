class Project < ApplicationRecord
  belongs_to :regular_user
  has_many :proposals, dependent: :destroy

  validates :title, :description, :end_date, :value, :work_style, :skills, presence: true

  enum status: { open: 5, closed: 10 }
end
