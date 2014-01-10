SchemeFinderFrontend::Application.routes.draw do
  resource :page, only: [] do
    member {
      get :about
    }
  end

  # current_audience should be [businesses, teachers]
  scope "/:current_audience" do
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
