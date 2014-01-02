SchemeFinderFrontend::Application.routes.draw do
  resource :page, only: [] do
    member {
      get :about
    }
  end

  resources :schemes, only: [:new, :create]

  root to: 'schemes#new'
end
