SchemeFinderFrontend::Application.routes.draw do
  resource :page, only: [] do
    member {
      get :about
      get :intro
      get :start
    }
  end

  # allow to speficy mobile agent
  scope "(:current_agent)", current_agent: /mobile/ do
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
  end

  root to: "pages#start"
end
