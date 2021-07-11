class V1::Hotels::SessionsController < ApplicationController
    before_action :sign_in_params, only: :create
    before_action :load_hotel_user, only: :create
    before_action :valid_token, only: [:destroy, :is_logged_in?]

    #sign_in
    def create
        if @hotel.valid_password?(sign_in_params[:password])
            sign_in "hotel", @hotel
            render json: {
                messages: "Signed in successfully!",
                logged_in: true,
                is_success: true,
                data: @hotel
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
        sign_out @hotel
        @hotel.generate_new_authentication_token
        render json: {
            messages: "signed out successfully!",
            is_success: true,
            data: {}
        }, status: :ok 
    end

    def is_logged_in?
        if @hotel
            render json: {
                logged_in: true,
                data: @hotel
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
        params.require(:hotel).permit(:email, :password)
    end

    def load_hotel_user
        @hotel = hotel.find_for_database_authentication(email: sign_in_params[:email])
        if @hotel
            return @hotel
        else
            render json: {
                messages: "Cannot get hotel user!",
                is_success: false,
                data: {}
            }, status: :unauthorized
        end
    end

    def valid_token
        @hotel = Hotel.find_by(authentication_token: request.headers["AUTH-TOKEN"])
        if @hotel
            return @hotel
        else
            render json: {
                messages: "Invalid token!",
                is_success: false,
                data: {}
            }, status: :unauthorized
        end
    end
end
