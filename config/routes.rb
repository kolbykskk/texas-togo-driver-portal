Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  get 'payment_sheets/create'

  devise_for :users, controllers: { registrations: "registrations" }

  authenticated :user do
    root 'campaigns#dashboard', as: :authenticated_root
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end
  
  get 'dashboard', to: 'campaigns#dashboard'
  get 'pricing', to: 'pages#pricing'
  get 'terms', to: 'pages#terms'
  get 'stripe_accounts/full', to: 'stripe_accounts#full'
  get 'debit_cards/new'
  post 'debit_cards/create', to: 'debit_cards#create'
  post 'debit_cards/destroy', to: 'debit_cards#destroy'
  post 'disputes', to: 'disputes#create'
  post 'instant_transfer', to: 'debit_cards#transfer'
  get 'payouts/:id', to: 'payouts#show', as: 'payout'
  post 'webhooks/stripe', to: 'webhooks#stripe'
  get 'payment_sheet/:id/disbursments', to: 'payment_sheets#disbursments'
  post 'failed-payout', to: 'debit_cards#failed_payout'

  get '/retry', to: 'payment_sheets#retry'
  get '/invite-drivers', to: 'users#invite'

  resources :users, only: [:index] do
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
  end

  resources :payment_sheets

  resources :campaigns

  resources :stripe_accounts

  resources :charges

  resources :bank_accounts
end
