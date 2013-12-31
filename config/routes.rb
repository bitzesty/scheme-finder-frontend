SchemeFinderFrontend::Application.routes.draw do
  resource :pages, only: [] do
    member {
      get :about
    }
  end

  root to: 'pages#about'
end
