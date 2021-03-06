class V1::Deliveries::RegistrationsController < ApplicationController
    before_action :ensure_params_exists, only: :create

    # signup
    def create
        delivery = Delivery.new(delivery_params)
        if delivery.save
            render json: {
                messages: "Signed up successfully!",
                logged_in: true,
                is_success: true,
                user_type: "delivery",
                delivery: delivery
            }, status: :created
        else
            render json: {
                messages: "Something wrong!",
                is_success: false,
                delivery: {}
            }, status: :unprocessable_entity
            
        end
    end

    private
    def delivery_params
        params.require(:delivery).permit(:email, :password, :password_confirmation, :name, :phone_no, :status)
    end

    def ensure_params_exists
        return if params[:delivery].present?
        render json: {
            messages: "Missing params!",
            is_success: false,
            data: {}
        }, status: :bad_request
    end
end
