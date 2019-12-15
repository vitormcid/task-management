class TasksController < ApplicationController
  respond_to :html, :json		
  def index
    in_progress = scoped_tasks.where(status: "in_progress")
    others = scoped_tasks.where("status != ?", "in_progress")
  	@tasks = in_progress + others
  end

  def new
    @scoped_teams = scoped_teams
    respond_modal_with Task.new
  end  

  def create
    Task.transaction do 
      @task = Task.create(tasks_params)
      @task.user_id = current_user.id unless current_user.admin?
      @task.save
    end  

    if @task.valid? 
      flash[:notice] = "Tarefa criada com sucesso"
    else  
      flash[:alert] = @task.errors.full_messages
    end      
    redirect_to tasks_path 
  end	 

  def show
    @task = Task.find(params[:id])
    respond_modal_with @task
  end  

  def successfully_completed
    @task = Task.find(params[:id])
    respond_modal_with @task
  end	  

  def cancelled
    @task = Task.find(params[:id])
    respond_modal_with @task
  end	

  def update
    @task = Task.find(params[:id])

    if params[:task][:end_at].present?
      Task.transaction  do 
        @task.end_at = params[:task][:end_at]
        @task.status = "finished"   
        flash[:notice] = "Tarefa finalizada com sucesso"    
      end   

    elsif params[:task][:cancellation_justification].present?
      Task.transaction do 
        @task.cancellation_justification= params[:task][:cancellation_justification]
        @task.status = "canceled"
        flash[:notice] = "Tarefa cancelada com sucesso"
      end  
    end 
    @task.save         
    redirect_to tasks_path 
  end  

  def scoped_tasks
    if current_user.admin?
      Task.joins(:team).merge(current_user.supervised_teams)
    else
      current_user.tasks
    end    
  end 

  def scoped_teams
    if current_user.admin?
      @scoped_teams = current_user.supervised_teams     
    else  
      @scoped_teams = current_user.teams
    end  
  end 

  def tasks_params
    params.require(:task).permit(:id,:name,:start_at, :end_at,
                                 :cancellation_justification,:status, :user_id, :team_id)
  end  
end
