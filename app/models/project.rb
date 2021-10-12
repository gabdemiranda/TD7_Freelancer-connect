class Project < ApplicationRecord
  validates :title, :description, :end_date, :value, :work_style, :skills, presence: true
end
