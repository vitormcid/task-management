class CreateTask < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
    	t.string :name
    	t.datetime :start_at
    	t.datetime :end_at
    	t.string :cancellation_justification
    	t.string :status
    	t.integer :user_id
    end
  end
end
