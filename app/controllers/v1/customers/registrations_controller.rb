class V1::Customers::RegistrationsController < ApplicationController
    before_action :ensure_params_exists, only: :create

    # signup
    def create
        customer = Customer.new(customer_params)
        if customer.save
            render json: {
                messages: "Signed up successfully!",
                is_success: true,
                user_type: "customer",
                customer: customer,
            }, status: :created
        else
            render json: {
                messages: "Something wrong!",
                is_success: false,
                data: {}
            }, status: :unprocessable_entity
            
        end
    end

    private
    def customer_params
        params.require(:customer).permit(:email, :password, :password_confirmation, :name, :phone_no, :address)
    end

    def ensure_params_exists
        return if params[:customer].present?
        render json: {
            messages: "Missing params!",
            is_success: false,
            data: {}
        }, status: :bad_request
    end
end
