class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  #display all - index - get '/articles'
  #new action - new - get '/articles/new'
  #create action - create - post '/articles'
  #display one - show - get '/articles/:id'
  #edit one - edit - get '/articles/:id/edit'
  #patch actions - update action - patch '/articles/:id'
  #put action - update action - put '/acticle/:id'
  #delete action - delete action - delete '/articles/:id'


  get '/' do
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do
    @recipe = Recipe.create(name: params["name"], ingredients: params["ingredients"], cook_time: params["cook_time"])

    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end


  get '/recipes/:id' do
    @recipe = Recipe.find(params["id"])

    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
       @recipe.name = params[:name]
       @recipe.ingredients = params[:ingredients]
       @recipe.cook_time = params[:cook_time]
       @recipe.save
       redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.delete
    redirect to '/recipes'
  end




end
