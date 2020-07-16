class CategoriesController < ApplicationController
	before_action :require_admin, only: [:create, :new]

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = 'Category Created'
			redirect_to categories_path
		else
			render 'new'
		end
	end

	def index
		@categories = Category.paginate(page: params[:page], per_page:5)
	end

	def new
		@category = Category.new	
	end

	def show
		@category = Category.find(params[:id])
		@category_articles = @category.articles.paginate(page: params[:page],per_page: 5)
	end

	private

	def category_params
		params.require(:category).permit(:name)
	end

	def require_admin
		if !logged_in? || (logged_in? and !curent_user.admin?)
			flash[:danger] = 'Only Admin Can Create Categories'
			redirect_to root_path
		end
	end
end