class Team < ApplicationRecord
	belongs_to :admin, :class_name => "User", :foreign_key => "admin_id", required: false
	has_many :tasks
	has_and_belongs_to_many :users
end
