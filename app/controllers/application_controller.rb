class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	def respond_modal_with(*args, &blk)
    	options = args.extract_options!
    	options[:responder] = ModalResponder
    	respond_with *args, options, &blk
 	end
end
