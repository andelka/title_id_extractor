Rails.application.routes.draw do
  get 'extractor/index'

  resources :keywords do
    collection { post :import}
  end

  root 'extractor#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
