Rails.application.routes.draw do
  root "file_records#index"
  resources :file_records
end
