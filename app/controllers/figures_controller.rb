require 'pry'

class FiguresController < ApplicationController

  get '/figures' do 
    #display a list of figures
    @figures = Figure.all #definne instance variable for view
    erb :'/figures/index' #show all figures view
  end 

  get '/figures/new' do 
    #return an HTML form for creating a new figure
    @landmarks = Landmark.all
    @titles = Title.all 
    erb :'/figures/new' #shows view with new figures form 
  end 

  get '/figures/:id' do 
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end 

  get '/figures/:id/edit' do 
    @figure = Figure.find_by_id(params[:id])
    @landmarks = Landmark.all 
    @titles = Title.all 
    erb :'/figures/edit'
  end 

  post '/figures' do 
    #create a new figure
    @figure = Figure.create(params[:figure])
    new_title = Title.new(params[:title])
    new_landmark = Landmark.new(params[:landmark])

      if !params[:landmark][:name].empty?
         @figure.landmarks << Landmark.create(params[:landmark])
       end
      if !params[:title][:name].empty?
         @figure.titles << Title.create(params[:title])
       end
       @figure.save
       redirect to "/figures/show"
  end 

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])

      if !params[:landmark][:name].empty?
        @figure.landmarks << Landmark.create(params[:landmark])
      end

      if !params[:title][:name].empty?
        @figure.titles << Title.create(params[:title])
      end
      
      @figure.save
      redirect to "/figures/#{@figure.id}"
  end 
  

end 