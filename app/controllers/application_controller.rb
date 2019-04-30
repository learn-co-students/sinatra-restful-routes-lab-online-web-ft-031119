class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes/new' do
    @recipe = Recipe.new
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    new_params = {}
    recipe = Recipe.find_by_id(params[:id])
    new_params[:name] = params[:name]
    new_params[:ingredients] = params[:ingredients]
    new_params[:cook_time] = params[:cook_time]
    recipe.update(new_params)

    redirect to "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do
    Recipe.destroy(params[:id])
    redirect to "/recipes"
  end


end
