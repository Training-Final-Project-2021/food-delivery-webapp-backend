class V1::Deliveries::DeliveriesController < ApplicationController
    before_action :valid_token
    
    def fetch_ready_order
        orders = OrderList.where(status: "Ready")
        if orders
            render json: {
                messages: "Successfully fetch ready orders!",
                is_success: true,
                orders: orders
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch ready orders!",
                is_success: true,
                orders: {}
            }, status: :internal_server_error
        end
    end

    def deliver_order
        order_id = params[:order_id]
        OrderList.find(order_id).where(status: "Ready").update_all(status: "Delivered")
    end

    private
    def valid_token
        @delivery = Delivery.find_by(authentication_token: request.headers["AUTH-TOKEN"])
        if @delivery
            return @delivery
        else
            render json: {
                messages: "Invalid token!",
                is_success: false,
                delivery: {}
            }, status: :unauthorized
        end
    end
    
end
