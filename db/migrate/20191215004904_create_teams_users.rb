class CreateTeamsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :teams_users do |t|
    	t.integer :user_id
    	t.integer :team_id
    end
  end
end
