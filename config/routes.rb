Rails.application.routes.draw do
  root to: "pages#index"
  get 'my_list', to: 'pages#my_list', as: 'my_list'
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }, sign_out_via: [:get, :delete]

  resources :resumes, except: [:index] do
    member do
      patch :toggle_active
    end
  end
  
  resources :vacancies, except: [:index] do
    member do
      patch :toggle_active
    end
  end
end
