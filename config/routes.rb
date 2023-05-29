Rails.application.routes.draw do
  resources :courses do
    resources :lessons, except: [:index, :show], controller: "courses/lessons"
    member do
      patch :generate_lessons
    end
  end
  resources :subjects
  resources :classrooms
  devise_for :users, controllers: { 
    confirmations: 'users/confirmations', 
    omniauth_callbacks: 'users/omniauth_callbacks', 
    registrations: 'users/registrations'
  }

  resources :users, only: [:index, :show, :destroy, :edit, :update] do
    member do
      patch :ban
      patch :resend_confirmation_instructions
      patch :resend_invitation
    end
  end

  root 'static_pages#landing_page'

  get 'calendar', to: 'static_pages#calendar'

  get '/About', to: 'static_pages#privacy_policy', as: :about
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
