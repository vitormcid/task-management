class TasksController < ApplicationController
  respond_to :html, :json		
  def index
  	@tasks = Task.all
  end

  def new
    respond_modal_with Task.new
  end  

  def create
    @task = Task.create(tasks_params)

    if @task.valid? 
      flash[:notice] = "Tarefa criada com sucesso"
    else  
      flash[:errors] = @task.errors.full_messages
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

  def tasks_params
    params.require(:task).permit(:id,:name,:start_at, :end_at,
                                 :cancellation_justification,:status, :user_id)
  end  
end
