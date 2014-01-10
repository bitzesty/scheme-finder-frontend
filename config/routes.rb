SchemeFinderFrontend::Application.routes.draw do
  resource :page, only: [] do
    member {
      get :about
    }
  end

  scope "/:current_audience", constraints: { current_audience: /businesses|teachers/  } do
    resources :schemes, only: [:new, :create, :index] do
      collection {
        get :search
      }

      scope module: :schemes do
        resources :feedbacks, only: [:new, :create, :index]
      end
    end
  end

  root to: 'pages#start'
end
