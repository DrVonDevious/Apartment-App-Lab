class ApartmentsController < ApplicationController
  # add controller methods

  set :views, "app/views/apartments"

  get '/apartments' do
    @apartments = Apartment.all
    erb :index
  end  

  get '/apartments/new' do
    erb :new
  end

  get '/apartments/:id' do
    @apartment = current_apartment
    @tenants = Tenant.all

    @residents = @tenants.select { |t| t.apartment_id == @apartment.id }

    erb :show
  end  

  get '/apartments/:id/edit' do
    @apartment = current_apartment
    erb :edit
  end 

  post '/apartments' do
    @apartment = Apartment.create(params)
    redirect "/apartments/#{@apartment.id}"
  end  

  patch '/apartments/:id' do
    @apartment = current_apartment
    @apartment.update(address: params[:address])
    redirect "/apartments/#{@apartment.id}"
  end 

  delete '/apartments/:id' do 
    @tenants = Tenant.all
    @apartment = current_apartment
    # bignding.pry
    if @apartment.tenants.empty?
      @apartment.destroy 
    end  
    redirect '/apartments'
  end 

  def current_apartment
    Apartment.find(params[:id])
  end  

end
