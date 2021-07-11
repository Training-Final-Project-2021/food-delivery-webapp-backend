class V1::Hotels::HotelsController < ApplicationController
    def hotels_list
        hotel = Hotel.select(:id, :name, :address, :status, :discription, :rating)
        if hotel
            render json: {
                hotels: hotel
            }, status: :ok
        else
            render json: {
                messages: "Unable to fetch hotels"
            }, status: :internal_server_error
        end
    end

end
