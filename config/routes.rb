Rails.application.routes.draw do
  devise_for :admins
  devise_for :hotels
  devise_for :customers
  devise_for :deliveries
  namespace :v1, defaults: { format: :json } do

    namespace :deliveries do
      devise_scope :deliveries do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "sign_out", to: "sessions#destroy"
        get "is_logged_in", to: "sessions#is_logged_in?"
        put "deliver_order", to: "deliveries#deliver_order"
        get "fetch_ready_orders", to: "deliveries#fetch_ready_orders"
      end
    end

    namespace :customers do
      devise_scope :customers do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "sign_out", to: "sessions#destroy"
        get "is_logged_in", to: "sessions#is_logged_in?"
        post "add_to_cart", to: "customers#add_to_cart"
        get "show_cart", to: "customers#show_cart"
        post "create_order", to: "customers#create_order"
        delete "remove_form_cart", to: "customers#remove_from_cart"
        delete "cancel_order", to: "customers#cancel_order"
        put "reorder", to: "customers#reorder"
        get "fetch_delivered_orders", to: "customers#fetch_delivered_orders"
        put "confirm_delivery", to: "customers#confirm_delivery"
        get "view_order_history", to: "customers#view_order_history"
        get "view_order_status", to: "customers#view_order_status"
      end
    end

    namespace :hotels do
      devise_scope :hotels do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "sign_out", to: "sessions#destroy"
        get "is_logged_in", to: "sessions#is_logged_in?"
        get "hotels_list", to: "hotels#hotels_list"
        get "show_menu", to: "hotels#show_menu"
        put "verify_order", to: "hotels#verify_order"
        delete "cancel_order", to: "hotels#cancel_order"
        put "assign_delivery", to: "hotels#assign_delivery"
        get "show_pending_orders_status", to: "hotels#show_pending_orders_status"
        get "show_all_orders_status", to: "hotels#show_all_orders_status"
        get "show_confirmed_orders_status", to: "hotels#show_confirmed_orders_status"
      end
    end

    namespace :admins do
      devise_scope :admins do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "sign_out", to: "sessions#destroy"
        get "is_logged_in", to: "sessions#is_logged_in?"
        get "unverified_delivery_people", to: "admins#unverified_delivery_people"
        get "unverified_hotels", to: "admins#unverified_hotels"
        put "verify_delivery_person", to: "admins#verify_delivery_person"
        put "verify_hotel", to: "admins#verify_hotel"
      end
    end
  end
end