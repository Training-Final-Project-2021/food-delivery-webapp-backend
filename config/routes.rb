Rails.application.routes.draw do
  devise_for :deliveries
  namespace :v1, defaults: { format: :json } do
    devise_scope :deliveries do
      post "sign_up", to: "registrations#create"
      post "sign_in", to: "session#create"
      delete "sign_out", to: "session#destroy"
      get "is_logged_in", to: "session#is_logged_in?"
    end
  end
end