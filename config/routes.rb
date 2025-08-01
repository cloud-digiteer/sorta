Rails.application.routes.draw do
  devise_for :users
  root "file_records#index"
  resources :file_records do 
    member do 
      patch :toggle_status
    end
  end
end
