class V1::Customers::CustomersController < ApplicationController
    before_action :valid_token
    
    # def give_rating
    #     item_id = params[:item_id]
    #     rating = params[:rating]
    #     # Item.find(item_id).update(rating: rating)
    # end

    def add_to_cart
        order = Cart.create(customer_id: @customer.id, hotel_id: params[:cart][:hotel_id], item_id: params[:cart][:item_id],
                             item_quantity: params[:cart][:item_quantity], item_name: params[:cart][:item_name], item_price: params[:cart][:item_price], total_price: params[:cart][:total_price] )
        if order
            render json: {
                messages: "Successfully added to cart!",
                is_success: true,
                orders: order
            }, status: :created
        else
            render json: {
                messages: "Unable to add",
                is_success: false,
                orders: {}
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
                items: item
            }, status: :ok
        else
            render json: {
                messages: "Something went wrong!",
                items: {}
            }, status: :internal_server_error
        end
    end

    def show_cart
        carts = Cart.where(customer_id: @customer.id)
        if carts
            render json: {
                messages: "Fetched cart successfully!",
                is_success: true,
                carts: carts,
            }, status: :ok
        else
            render json: {
                messages: "Failed to fetch your cart!",
                is_success: false,
                carts: {}
            }, state: :internal_server_error
        end
    end

    def create_order
        orders = Cart.where(customer_id: @customer.id)
        if orders
            orders.each do |order|
                OrdersList.create(customer_id: order.customer_id, hotel_id: order.hotel_id, item_id: order.item_id, item_quantity: order.item_quantity, status: "Pending",
                                    item_quantity: order.item_quantity, item_name: order.item_name, item_price: order.item_price, total_price: order.total_price)
                Cart.where(customer_id: @customer.id).destroy_all
            end
            render json: {
                messages: "Order placed successfully, please wait until the restaurant confirms it!",
                is_success: true,
                carts: {},
                orders: orders
            }, status: :ok
        else
            render json: {
                messages: "Unable to process your order!",
                is_success: false
            }, status: :internal_server_error
        end
    end

    def cancel_order
        id = params[:order_id]
        order = OrdersList.find(id)
        if order
            OrdersList.where(id: order_id).update_all(status: "Cancelled by user")
            render json: {
                messages: "Order cancelled by user!",
                data: order
            }, status: :ok
        else
            render json: {
                messages: "Something went wrong!",
                data: {}
            }, status: :internal_server_error
        end
    end

    def view_order_status
        orders = OrdersList.where(customer_id: @customer.id)
        if orders
            render json: {
                messages: "Successfully fetched your orders!",
                is_success: true,
                orders: orders
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch your ",
                is_success: false,
                orders: {}
            }, status: :internal_server_error
        end
    end

    def view_order_history
        orders = OrdersList.where(customer_id: @customer.id, status: "Received")
        if orders
            render json: {
                messages: "Successfully fetched orders history!",
                is_success: true,
                orders: orders
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch orders history!",
                is_success: true,
                orders: {}
            }, status: :internal_server_error
        end
    end

    def reorder
        order_id = params[:order_id]
        order = OrdersList.find(order_id)
        if order
            OrdersList.create(customer_id: order.customer_id, hotel_id: order.hotel_id, item_id: order.item_id,
                                item_quantity: order.item_quantity, status: "Pending", item_name: order.item_name, item_price: order.item_price, total_price: order.total_price)
            render json: {
                messages: "Order placed successfully, please wait until the restaurant confirms it!"
            }, status: :ok
        else
            render json: {
                messages: "Unable to process your order!"
            }, status: :internal_server_error
        end
    end

    def confirm_delivery
        order_id = params[:order_id]
        OrdersList.where(id: order_id, status: "Delivered").update_all(status: "Received")
        render json: {
            messages: "Order received by customer, Enjoy your meal!"
        }, status: :ok
    end

    def fetch_delivered_orders
        orders = OrdersList.where(customer_id: @customer.id, status: "Delivered")
        if orders
            render json: {
                messages: "Successfully fetched delivered orders!",
                is_success: true,
                orders: orders
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch delivered orders!",
                is_success: true,
                orders: {}
            }, status: :internal_server_error
        end
    end

    private
    def valid_token
        @customer = Customer.find_by(authentication_token: request.headers["AUTH-TOKEN"])
        if @customer
            return @customer
        else
            render json: {
                messages: "Invalid token!",
                is_success: false,
                data: {}
            }, status: :unauthorized
        end
    end
end
