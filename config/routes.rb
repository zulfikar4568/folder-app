Rails.application.routes.draw do
  devise_for :accounts
  root to: "folders#index"

  get 'documents/download', to: 'documents#download'

  resources :folders
  resources :documents
  resources :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
