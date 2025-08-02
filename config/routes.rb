Rails.application.routes.draw do
  devise_for :users, controllers: {
    passwords: 'passwords'
  }
  root "file_records#index"
  resources :file_records do
    member do
      patch :toggle_status
    end
  end
end
