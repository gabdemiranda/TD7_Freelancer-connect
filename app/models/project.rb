class Project < ApplicationRecord
  has_many :proposals, dependent: :destroy
  validates :title, :description, :end_date, :value, :work_style, :skills, presence: true
end
