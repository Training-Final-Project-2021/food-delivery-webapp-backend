class V1::Hotels::RegistrationsController < ApplicationController
    before_action :ensure_params_exists, only: :create

    # signup
    def create
        hotel = Hotel.new(hotel_params)
        if hotel.save
            render json: {
                messages: "Signed up successfully!",
                is_success: true,
                data: {
                    hotel: hotel,
                }
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
    def hotel_params
        params.require(:hotel).permit(:email, :password, :password_confirmation, :name)
    end

    def ensure_params_exists
        return if params[:hotel].present?
        render json: {
            messages: "Missing params!",
            is_success: false,
            data: {}
        }, status: :bad_request
    end
end
