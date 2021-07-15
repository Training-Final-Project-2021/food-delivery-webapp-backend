class V1::Hotels::HotelsController < ApplicationController
    before_action :valid_token
    skip_before_action :valid_token, only: [:hotels_list, :show_menu]

    def hotels_list
        hotel = Hotel.select(:id, :name, :address, :status, :discription, :rating)
        if hotel
            render json: {
                is_success: true,
                hotels: hotel
            }, status: :ok
        else
            render json: {
                is_success: false,
                messages: "Unable to fetch hotels"
            }, status: :internal_server_error
        end
    end

    def show_menu
        hotel_id = params[:hotel_id]
        menu = Item.where(hotel_id: hotel_id)
        if menu
            render json: {
                is_success: true,
                items: menu
            }, status: :ok
        else
            render json: {
                is_success: false,
                items: {},
                messages: "Unable to fetch hotel menu!"
            }, status: :internal_server_error
        end
    end

    def show_all_orders_status
        orders = OrdersList.where(hotel_id: @hotel.id)
        if orders
            render json: {
                messages: "Orders fetched successfully!",
                is_success: true,
                orders: orders
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch",
                is_success: false,
                orders: {}
            }, status: :internal_server_error
        end
    end

    def show_pending_orders_status
        orders = OrdersList.where(hotel_id: @hotel.id, status: "Pending")
        if orders
            render json: {
                messages: "Pending orders fetched successfully!",
                is_success: true,
                orders: orders
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch",
                is_success: false,
                orders: {}
            }, status: :internal_server_error
        end
    end

    def show_confirmed_orders_status
        orders = OrdersList.where(hotel_id: @hotel.id, status: "Confirmed")
        if orders
            render json: {
                messages: "Confirmed orders fetched successfully!",
                is_success: true,
                orders: orders
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch",
                is_success: false,
                orders: {}
            }, status: :internal_server_error
        end
    end

    def verify_order
        order_id = params[:order_id]
        OrdersList.where(id: order_id, status: "Pending").update_all(status: "Confirmed")
        render json: {
            messages: "Your order is confirmed from hotel!"
        }, status: :ok
    end

    def cancel_order
        order_id = params[:order_id]
        OrdersList.where(id: order_id).update_all(status: "Cancelled by hotel")
        render json: {
            messages: "Order cancelled from hotel!"
        }, status: :ok
    end

    def assign_delivery
        order_id = params[:order_id]
        OrdersList.where(id: order_id, status: "Confirmed").update_all(status: "Ready")
        render json: {
            messages: "The order will be delivered soon....."
        }, status: :ok
    end

    def send_email_notification
    end

    private
    def valid_token
        @hotel = Hotel.find_by(authentication_token: request.headers["AUTH-TOKEN"])
        if @hotel
            return @hotel
        else
            render json: {
                messages: "Invalid token!",
                is_success: false,
                hotel: {}
            }, status: :unauthorized
        end
    end
end
