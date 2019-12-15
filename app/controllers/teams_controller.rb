class TeamsController < ApplicationController
  respond_to :html, :json		
  before_action :authenticate_admin!
  def index
    @teams = current_user.supervised_teams 
  end

  def new
    respond_modal_with Team.new
  end  

  def create
    Team.transaction do 
      @team = Team.create(team_params)
      @team.admin_id = current_user.id
      @team.save
    end  
     
    if @team.valid? 
      flash[:notice] = "Time criado com sucesso"
    else  
      flash[:alert] = @team.errors.full_messages
    end      
    redirect_to teams_path 
  end	 

  def edit
    @team = Team.find(params[:id])
    respond_modal_with @team
  end 
  
  def update
   
  end  

  def destroy
    @team = Team.find(params[:id])
    @team.delete
    flash[:notice] = "Time deletado com sucesso"
    redirect_to teams_path 
  end  

  def team_params
    params.require(:team).permit(:id,:name,:admin_id,user_ids:[])
  end  
end
