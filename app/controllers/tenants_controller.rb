class TenantsController < ApplicationController
  # add controller methods

  set :views, 'app/views/tenants'

  get '/tenants' do
    @tenants = Tenant.all
    erb :index
  end 

  get '/tenants/new' do
    @apartments = Apartment.all 
    erb :new
  end 

  get '/tenants/:id' do
    @tenant = current_tenant
    erb :show 
  end

  get '/tenants/:id/edit' do
    @apartments = Apartment.all
    @tenant = current_tenant
    erb :edit
  end  

  post '/tenants' do
    @tenant = Tenant.create(params)
    redirect "/tenants/#{@tenant.id}"
  end  

  patch '/tenants/:id' do
    @tenant = current_tenant
    @tenant.update(name: params[:name], apartment_id: params[:apartment_id])
    redirect "/tenants/#{@tenant.id}"
  end  

  delete '/tenants/:id' do
    tenant = current_tenant
    tenant.destroy
    redirect '/tenants'
  end  

  def current_tenant
    Tenant.find(params[:id])
  end  

end
