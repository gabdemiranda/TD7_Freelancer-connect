class FreelancerUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile
  accepts_nested_attributes_for :profile
  has_many :proposals
  has_many :projects, through: :proposals
end
