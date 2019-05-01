class ApplicationController < Sinatra::Base
set :views, Proc.new { File.join(root, "../views/") } 
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

	get '/recipes' do
		@recipes = Recipe.all
		# binding.pry
 		erb :index
	end
 
	post '/recipes' do
	  @recipes = Recipe.create(:name => params[:name], :ingredients => params[:ingredients],:cook_time => params[:cook_time])
	  redirect to "/recipe/#{@recipes.id}"
	end

	get '/recipes/new' do
	  erb :new
	end
	 

	get '/recipes/:id' do
	  @recipes = Recipe.find_by_id(params[:id])
	  erb :show
	end

	get '/recipes/:id/edit' do
	  @recipes = Recipe.find_by_id(params[:id])
	  erb :edit
	end

	patch '/recipes/:id' do #edit action
	  @recipes = Recipe.find_by_id(params[:id])
	  @recipes.name = params[:name]
	  @recipes.ingredients = params[:ingredients]
	  @recipes.cook_time = params[:cook_time]
	  @recipes.save
	  redirect to "/recipes/#{@recipes.id}"
	end

end
