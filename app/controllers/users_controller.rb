class UsersController < ApplicationController

	def my_portfolio
		@user = current_user
		@user_stocks = current_user.stocks
	end
	
	def my_friends
		@friendships = current_user.friends
	end
	
	def search
		if params[:search_param].blank?
			flash.now[:danger] = "You have entered an empty search string"
		else
			# @users = all users that match search_params
			@users = User.search(params[:search_param])
			# reassign @users to @users except current_user
			@users = current_user.except_current_user(@users)
			flash.now[:danger] = "No users match this search criteria" if @users.blank?
		end
		respond_to do |format|
			format.js { render partial: 'friends/result' }
		end
	end
	
end