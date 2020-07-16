class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.user = curent_user
		if@article.save
			flash[:success] = 'Created'
			redirect_to article_path(@article)
		else
			render 'new'
		end
	end

	def show
		
	end

	def index
		@articles = Article.paginate(page: params[:page],per_page: 5)
	end

	def edit

	end

	def update
		if@article.update(article_params)
			flash[:success] = 'Updated'
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
		if @article.destroy
			flash[:danger] = "article was successfully deleted"
			redirect_to articles_path
		else
		end
	end

 private

 	def set_article
 		@article = Article.find(params[:id])
 	end

 	def article_params
		params.require(:article).permit(:title, :description, category_ids: [])
	end

	def require_same_user
		if curent_user != @article.user and !curent_user.admin?
			flash[:danger] = 'You Can Only Edit Or Delete Your Own Article'
			redirect_to root_path
		end
	end
end
