Rails.application.routes.draw do
  # devise_for :admins
  # devise_for :hotels
  # devise_for :customers
  # devise_for :deliveries
  namespace :v1, defaults: { format: :json } do
    namespace :deliveries do
      devise_scope :deliveries do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "sign_out", to: "sessions#destroy"
        get "is_logged_in", to: "sessions#is_logged_in?"
      end
    end

    namespace :customers do
      devise_scope :customers do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "sign_out", to: "sessions#destroy"
        get "is_logged_in", to: "sessions#is_logged_in?"
      end
    end

    namespace :hotels do
      devise_scope :hotels do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "sign_out", to: "sessions#destroy"
        get "is_logged_in", to: "sessions#is_logged_in?"
        get "hotels_list", to: "hotels#hotels_list"
      end
    end

    namespace :admins do
      devise_scope :admins do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "sign_out", to: "sessions#destroy"
        get "is_logged_in", to: "sessions#is_logged_in?"
      end
    end
  end
end