Rails.application.routes.draw do



  get '/events/hosting', to: 'events#hosting'
  get '/events/attending', to: 'events#attending'

  resources :events
  resources :attendings
  resources :comments

  devise_for :users,
  path: '',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  get '/users', to: 'users#index'
  get '/auth', to: 'users#auth'

  



end
