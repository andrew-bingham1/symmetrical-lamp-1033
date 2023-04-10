Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\
  get '/customers/:customer_id', to: 'customer#show'

  post '/customer_item', to: 'customer_item#create'

  get '/items', to: 'item#index'
end
