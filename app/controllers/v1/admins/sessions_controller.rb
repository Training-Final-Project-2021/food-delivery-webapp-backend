class V1::Admins::SessionsController < ApplicationController
    before_action :sign_in_params, only: :create
    before_action :load_admin_user, only: :create
    before_action :valid_token, only: [:destroy, :is_logged_in?]

    #sign_in
    def create
        if @admin.valid_password?(sign_in_params[:password])
            sign_in "admin", @admin
            render json: {
                messages: "Signed in successfully!",
                logged_in: true,
                is_success: true,
                user_type: "admin",
                admin: @admin
            }, status: :ok
        else
            render json: {
                messages: "Unautherized",
                logged_in: false,
                is_success: false,
                admin: {}
            }, status: :unauthorized
        end
    end
    #sign out
    def destroy
        sign_out @admin
        @admin.generate_new_authentication_token
        render json: {
            messages: "signed out successfully!",
            is_success: true,
            logged_in: false,
            admin: {}
        }, status: :ok 
    end

    def is_logged_in?
        if @admin
            render json: {
                logged_in: true,
                is_success: true,
                user_type: "admin",
                admin: @admin
            }, status: :ok
        else
            render json: {
                logged_in: false,
                is_success: false,
                admin: {}
            }, status: :unprocessable_entity
        end
    end

    private
    def sign_in_params
        params.require(:admin).permit(:email, :password)
    end

    def load_admin_user
        @admin = Admin.find_for_database_authentication(email: sign_in_params[:email])
        if @admin
            return @admin
        else
            render json: {
                messages: "Cannot get admin user!",
                is_success: false,
                admin: {}
            }, status: :unauthorized
        end
    end

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
