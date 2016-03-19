Rails.application.routes.draw do
  root "welcome#index"
  resources :item_photos
  resources :items
  mount Knock::Engine => "/knock"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
