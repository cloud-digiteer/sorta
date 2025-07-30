Rails.application.routes.draw do
  devise_for :users
  root "file_records#index"
  resources :file_records
end
