Rails.application.routes.draw do

  namespace :users do
    resources :invoices do
      member do
        get :email
        get :print
      end
    end
  end

end
