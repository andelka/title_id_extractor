Rails.application.routes.draw do
  get 'extractor/index'

  resources :keywords

  root 'extractor#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
