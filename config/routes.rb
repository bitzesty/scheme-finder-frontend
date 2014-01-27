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
        get :mobile_search
      }

      scope module: :schemes do
        resources :feedbacks, only: [:new, :create, :index]
      end
    end

    root to: "schemes#index", as: :root_with_audience
  end

  root to: "pages#start"
end
