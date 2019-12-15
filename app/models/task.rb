class Task < ApplicationRecord
	extend Enumerize
	belongs_to :user, foreign_key: 'user_id', required: false
	belongs_to :team, foreign_key: 'team_id', required:false
	enumerize :status, in: [:in_progress, :finished, :canceled], default: :in_progress
	validates :name, :start_at , presence: true
	validate  :start_at_greater_current_date
	validate  :end_at_greater_start_at

	def start_at_formated
		start_at&.strftime("%d/%m/%y %H:%M")
	end	

	def start_at_greater_current_date
		return unless start_at.present?	
		if start_at.to_datetime < DateTime.current - 3.hours
			self.errors[:base] << "A data de início deve ser maior que a data atual"
		end	
	end	

	def end_at_greater_start_at
		return unless end_at.present?
		if start_at > end_at
			self.errors[:base] << "A data final deve ser maior que a data de início"
		end	
	end	
end
