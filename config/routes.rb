Rails.application.routes.draw do
  devise_for :users
  root to: 'categories#index'
  get 'categories/:category_id/tasks/today' => 'tasks#today', as: 'tasks_today'

  resources :categories do
    resources :tasks
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  

end
