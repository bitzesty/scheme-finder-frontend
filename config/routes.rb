SchemeFinderFrontend::Application.routes.draw do
  resource :page, only: [] do
    member {
      get :about
    }
  end

  resources :schemes, only: [:new, :create, :index]

  root to: 'schemes#index'
end
