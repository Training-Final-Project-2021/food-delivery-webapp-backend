class V1::Admins::AdminsController < ApplicationController
    before_action :valid_token

    def unverified_delivery_people
        people = Delivery.all
        if people
            render json: {
                messages: "Successfully fetched unverified peoples!",
                is_success: true,
                delivery_people: people
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch!",
                is_success: false,
                delivery_people: {}
            }, status: :internal_server_error
        end
    end

    def verify_delivery_person
        delivery_id = params[:delivery_id]
        Delivery.where(id: delivery_id).update(status: "Verified")
        render json: {
            messages: "Verified delivery person!"
        }, status: :ok
    end

    def unverified_hotels
        hotels = Hotel.all
        if hotels
            render json: {
                messages: "Successfully fetched unverified hotels!",
                is_success: true,
                hotels: hotels
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch!",
                is_success: false,
                hotels: {}
            }, status: :internal_server_error
        end
    end

    def verify_hotel
        hotel_id = params[:hotel_id]
        Hotel.where(id: hotel_id).update(status: "Verified")
        render json: {
            messages: "Verified Hotel!"
        }, status: :ok
    end

    private
    def valid_token
        @admin = Admin.find_by(authentication_token: request.headers["AUTH-TOKEN"])
        if @admin
            return @admin
        else
            render json: {
                messages: "Invalid token!",
                is_success: false,
                admin: {}
            }, status: :unauthorized
        end
    end
end
