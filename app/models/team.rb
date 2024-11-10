class Team < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :team_memberships, dependent: :destroy
  has_many :members, through: :team_memberships, source: :user

  # Validations
  validates :name, presence: true, uniqueness: true
end