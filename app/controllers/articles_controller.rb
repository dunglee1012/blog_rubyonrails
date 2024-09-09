class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  def index
    if params[:search].present?
      @articles = Article.where('title LIKE ?', "%#{params[:search]}%")
    else
      #@articles = Article.all 
      #pagging 
      @articles = Article.page(params[:page]).per(5)
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  def active_article
    @articles = Article.where(status: ['public', 'private'])
    # render :index #trả về index luôn
    render :active_article
  end

  def archived_article
    @articles = Article.where(status: 'archived')
    render :archived_article
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :image)
    end
end
