Rails.application.routes.draw do
    root to: "urls#new"
  resources :urls
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/:short_url", to: "urls#show"



end
