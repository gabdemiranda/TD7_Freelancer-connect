class Project < ApplicationRecord
  has_many :proposals
  validates :title, :description, :end_date, :value, :work_style, :skills, presence: true
end
