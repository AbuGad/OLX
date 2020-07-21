class FriendshipsController < ApplicationController

	def destroy
		@friendship = curent_user.friendships.where(friend_id: params[:id]).first
		@friendship.destroy
		flash[:destroy] = "Friend Was Successfully Removed"
		redirect_to my_friends_path
	end
end