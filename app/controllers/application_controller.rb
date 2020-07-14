class ApplicationController < ActionController::Base
	
helper_method :curent_user, :logged_in?

	def curent_user
		@curent_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!curent_user
	end

	def require_user
		if !logged_in?
			flash[:danger] = 'You Have To Log-in First'
			redirect_to root_path
		end
	end
end
