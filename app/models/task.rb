class Task < ApplicationRecord
	extend Enumerize
	belongs_to :user, foreign_key: 'user_id', required: false
	enumerize :status, in: [:in_progress, :finished, :canceled], default: :in_progress
end
