class V1::Customers::CustomersController < ApplicationController
    before_action :authenticate_customer!
    @customer_id = current_customer.id

    def show_hotels_list
        hotel = Hotel.select(:id, :name, :address, :status, :discription, :rating)
        if hotel
            render json: {
                hotels: hotel
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch hotels",
                errors: hotel.errors.full_messages
            }, status: :internal_server_error
        end
    end

    def show_menu
        hotel_id = params[:hotel_id]
        menu = Item.find_by(hotel_id: hotel_id)
        if menu
            render json: {
                menu: menu
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch menu",
                errors: menu.errors.full_messages
            }, status: :internal_server_error
        end
    end

    def add_to_cart
        order = Cart.new(customer_id: @customer_id, hotel_id: params[:hotel_id], item_id: params[:item_id], item_quantity: params[:quantity] )
        if order
            render json: {
                messages: "Successfully added to cart!",
                is_success: true,
                data: order
            }, status: :created
        else
            render json: {
                messages: "Unable to add",
                is_success: false,
                data: {}
            }, status: :internal_server_error
        end
    end

    def remove_from_cart
        id = params[:item_id]
        item = Item.find(id)
        if item
            Item.find(id).destroy
            render json: {
                messages: "Item removed successfully!",
                data: item
            }, status: :ok
        else
            render json: {
                messages: "Something went wrong!"
                data: {}
            }, status: :internal_server_error
        end
    end

    def confirm_order
        orders = Cart.where(customer_id: @customer_id)
        if orders
            orders.each do |order|
                OrdersList.create(customer_id: order.customer_id, hotel_id: order.hotel_id, item_id: order.item_id, item_quantity: order.item_quantity, status: "Pending")
            end
            render json: {
                messages: "Successfully order, please wait until the restaurant confirms it!",
                data: orders
            }, status: :ok
        else
            render json: {
                messages: "Unable to process your order!"
            }, status: :internal_server_error
        end
    end

    def cancel_order
        id = params[:order_id]
        order = OrdersList.find(id)
        if order
            OrdersList.find(id).destroy
            render json: {
                messages: "Order cancelled!",
                data: order
            }, status: :ok
        else
            render json: {
                messages: "Something went wrong!",
                data: {}
            }, status: :internal_server_error
        end

    end

    def view_order_history
        order_history = OrdersHistory.where(customer_id: @customer_id)
        if order_history
            render json: {
                data: order_history
            }, status: :ok
        else
            render json: {
                messages: "Unable to retrieve orders history!"
                data: {}
            }, status: :internal_server_error
        end
    end

end
