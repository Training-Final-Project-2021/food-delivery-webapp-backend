class V1::Customers::SessionsController < ApplicationController
    before_action :sign_in_params, only: :create
    before_action :load_customer_user, only: :create
    before_action :valid_token, only: [:destroy, :is_logged_in?]

    #sign_in
    def create
        if @customer.valid_password?(sign_in_params[:password])
            sign_in "customer", @customer
            render json: {
                messages: "Signed in successfully!",
                logged_in: true,
                is_success: true,
                data: @customer
            }, status: :ok
        else
            render json: {
                messages: "Unautherized",
                logged_in: false,
                is_success: false,
                data: {}
            }, status: :unauthorized
        end
    end
    #sign out
    def destroy
        sign_out @customer
        @customer.generate_new_authentication_token
        render json: {
            messages: "signed out successfully!",
            is_success: true,
            data: {}
        }, status: :ok 
    end

    def is_logged_in?
        if @customer
            render json: {
                logged_in: true,
                data: @customer
            }, status: :ok
        else
            render json: {
                logged_in: false,
                data: {}
            }, status: :unprocessable_entity
        end
    end

    private
    def sign_in_params
        params.require(:customer).permit(:email, :password)
    end

    def load_customer_user
        @customer = Customer.find_for_database_authentication(email: sign_in_params[:email])
        if @customer
            return @customer
        else
            render json: {
                messages: "Cannot get customer user!",
                is_success: false,
                data: {}
            }, status: :unauthorized
        end
    end

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
