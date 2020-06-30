Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :students, only: [:new, :create, :show, :edit, :update]
  resources :workout_classes
  resources :instructors
  root 'workout_classes#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get 'admin/home', to: 'admin#home'
  get 'admin/instructors', to: 'admin#instructors'
  get '/workout_classes/:id/signup', to: 'workout_classes#signup', as: 'signup'
end
