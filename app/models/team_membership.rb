class TeamMembership < ApplicationRecord
  belongs_to :team
  belongs_to :user, foreign_key: 'user_id'
end