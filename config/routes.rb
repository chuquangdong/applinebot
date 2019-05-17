Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/index' => 'application#index'
  get '/index' => 'application#index'
end
