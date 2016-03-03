class FiguresController < ApplicationController

  get '/figures' do 
    #display a list of figures
    @figures = Figure.all #definne instance variable for view
    erb :'/figures/index' #show all figures view
  end 

  get '/figures/new' do 
  #return an HTML form for creating a new figure
    erb :'/figures/new' #shows view with new figures form 
  end 

  post '/figures' do 
    #create a new figure
    @figure = Figure.create(params[:figure])
    @figure.landmark = Landmark.find_or_create_by_name(params[:landmark_name])
    @figure.title = Title.find_or_create_by(params[:title_name])

      if !params[:landmark][:name].empty?
         @figure.landmarks << Landmark.create(params[:landmark])
       end
      if !params[:title][:name].empty?
         @figure.titles << Title.create(params[:title])
       end
       @figure.save
       redirect to "/figures/#{@figure.id}"
  end 

  get '/figures/:id' do 
    #display a specific figure
    @figure = Figure.find(params[:id]) #define instance variable for view
    erb :'/figures/show' #shows single figuree view
  end 

  get '/figures/:id/edit' do 
    #return an HTML form for editing a figure
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end 


end 