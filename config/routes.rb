Rails.application.routes.draw do
  
  namespace :api, defaults: {format: 'json'} do #/api/[controller]
    resources :babies do
      resources :activity_logs
    end
    resources :assistants do
      resources :activity_logs
    end
    resources :activity_logs do
      resources :activity_logs
    end
    resources :activities do
      resources :activity_logs
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
