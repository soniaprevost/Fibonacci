Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: 'dashboard#show', as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: 'marketing#index'
  end

  controller 'clearance/passwords' do
    resources :passwords, only: [:create, :new]
  end

  controller 'clearance/sessions' do
    resource :session, controller: 'clearance/sessions', only: [:create]
    get '/sign_in' => :new
    delete '/sign_out' => :destroy, as: :sign_out
  end

  controller :users do
    resources :users, only: [:create] do
      member do
        get '/technical_details', to: 'users#technical_details'
        put '/complete_profile', to: 'users#complete_profile'
      end
      resource :password, only: [:create, :edit, :update]
    end
    get '/sign_up' => :new, as: :sign_up
  end
end
