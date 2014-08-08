Rails.application.routes.draw do


  mount Forem::Engine, :at => '/forums'

  devise_for :users

  resources :sheets

  root to: 'pages#home'

end
