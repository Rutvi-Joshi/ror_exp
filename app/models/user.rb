class User < ApplicationRecord
  # has_secure_password
  # rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owned_teams, class_name: 'Team', foreign_key: :owner_id

  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships

  def inspect
    super
  rescue ArgumentError
    "User: #{self.id}"
  end
end
