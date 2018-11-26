class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:show,:index]
    
   
    def index
     @articles = Article.all
    end
    def show
         @article = Article.find(params[:id])
        @article.update_visits_count
        @comment = Comment.new
    end
    def new
      @article = Article.new
    end
    def edit
      @article = Article.find(params[:id])
    end
    def create

        @article = current_user.articles.new(article_params)
        if @article.save
            flash[:success] = "Articulo publicado exitosamente"
            
            redirect_to @article
          else
            flash[:error] = "Algo salio mal, el post no fue publicado"
            render 'new'
          end
    end
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end
    def update
       
        @article = Article.find(params[:id])
        if @article.update_attributes(article_params)
          flash[:success] = "Article was successfully updated"
          redirect_to @article
        else
          flash[:error] = "Something went wrong"
          render :edit
        end
    end

  
  def myarticles
      @myarticles = current_user.articles.order("created_at DESC")
  end
  

    private

   
   

    def article_params
        params.require(:article).permit(:title,:body)
    end

end
