class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	def respond_modal_with(*args, &blk)
    	options = args.extract_options!
    	options[:responder] = ModalResponder
    	respond_with *args, options, &blk
 	end

 	def authenticate_admin!
  		authenticate_user!

  		unless current_user.admin?
	  		flash[:alert] = "Apenas administradores podem acessar essa página"
	  		redirect_to tasks_path status: :forbidden 
	  	end	
	end
end
