class UsersController < ApplicationController
	before_action :set_user,only: [:edit, :update,:show]
	before_action :require_same_user, only: [:edit, :update]
	before_action :require_admin, only: [:destroy]
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success]=  "Welceome #{@user.username}"
			redirect_to user_path(@user)
		else
			render'new'
		end	
	end

	def edit
		
	end

	def update
		if @user.update(user_params)
			flash[:success] = 'User Info updated'
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end

	def index
		@users = User.paginate(page: params[:page],per_page: 3)
	end

	def show
		
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:danger] = 'User And All Articles Created Was Successfully Deleted'
		redirect_to users_path
	end

	def my_friends
		@friendships = curent_user.friends
	end

	def search
		@users = User.search(params[:search_param])

		if @users
			@users = curent_user.except_curent_user(@users)
			render partial: 'friends/lookup'
		else
			render status: :not_found, nothing: true
		end
	end

	def add_friend
		@friend= User.find(params[:friend])
		curent_user.friendships.build(friend_id: @friend.id)

		if curent_user.save
			redirect_to my_friends_path
			flash[:notice] = 'You Now Friend'
		else
			redirect_to my_friends_path
			flash[:error] = 'Some Thing Wrong'
		end
	end

	private
	def user_params
		params.require(:user).permit(:username,:email,:password)
	end

	def set_user
		@user = User.find(params[:id])
	end
	
	def require_same_user
		if curent_user != @user and !curent_user.admin?
			flash[:danger] = 'You Can Edit Your Own Account'
			redirect_to root_path
		end
	end

	def require_admin
		if logged_in? and !curent_user.admin?
			flash[:danger] = 'Only Admin Can Do That Action'
			redirect_to root_path
		end
	end
end