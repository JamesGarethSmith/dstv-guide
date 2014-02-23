Guide::Application.routes.draw do
  resources :matches
  root 'guide#index'
end
