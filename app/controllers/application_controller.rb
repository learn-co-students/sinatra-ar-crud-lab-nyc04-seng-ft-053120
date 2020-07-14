
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    # grab all of the articles and store them in an instance variable, @articles
    @articles = Article.all
    
    erb :index
    # render the index.erb view. That view should use ERB to iterate over @articles and render them on the page.
  end

  get '/articles/new' do
    erb :new
    # renders the new.erb view (a blank form that should submit a POST request to /articles)
  end

  get '/articles/:id' do
    # grab the article with the id that is in the params and set it equal to @article
    @article = Article.find(params[:id])

    # render the show.erb view page. That view should use ERB to render the @article's title and content.
    erb :show
  end
  
  post '/articles' do
    # creates a new article from the params from the form
    new_article = Article.create(params)
    
    # redirects to '/articles/:id'
    redirect "/articles/#{new_article.id}"
  end

  get '/articles/:id/edit' do
    # renders the view edit.erb, contain a form to update a specific article--similar to the form you made for a new article, but the fields should be pre-populated with the existing title and content of the article.
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(title: params[:title], content: params[:content])

    redirect "/articles/#{@article.id}"
  end

  delete "/articles/:id" do
    # To initiate this action, we'll add a "delete" button to the show page
    Article.destroy(params[:id])
    redirect "/articles"
  end
end
