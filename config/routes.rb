Rails.application.routes.draw do
  resources :clients, only: [:index] do
    resources :policies, only: [:index]
    collection do
      get 'count_all'
    end
  end

  resources :policies, only: [:index] do
    collection do
      get 'count_all'
    end
  end

  resources :carriers, only: [:index] do
    collection do
      get 'count_all'
    end
  end
end
