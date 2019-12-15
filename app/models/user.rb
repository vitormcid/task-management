class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks
  has_and_belongs_to_many :teams

  def supervised_teams
  	return unless admin?
  	Team.where(admin_id: id)
  end	
end
