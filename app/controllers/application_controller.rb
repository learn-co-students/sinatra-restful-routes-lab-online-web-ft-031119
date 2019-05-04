class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  # index
  get "/recipes" do
    @recipe = Recipe.all
    erb :index
  end

  # create
  post "/recipes" do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{ @recipe.id }"
  end

  # new
  get "/recipes/new" do
    erb :new
  end

  # show
  get "/recipes/:id" do
    @recipe= Recipe.find_by_id(params[:id])
    erb :show
  end

  # edit
  get "/recipes/:id/edit" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  # update
  patch "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{ @recipe.id }"
  end

  #delete
  delete "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to "/recipes"
  end

end
