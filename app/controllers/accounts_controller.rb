class AccountsController < ApplicationController
    before_action :set_account, only: [:edit, :update, :destroy]
    before_action :authenticate_account!
    load_and_authorize_resource
    
    def index
        if account_signed_in?
            @accounts = Account.all
        else
            redirect_to new_account_session_path
        end
    end

    def show
        if account_signed_in?
            @profile = Account.find(params[:id])
        else
            redirect_to new_account_session_path
        end
    end
    
    def edit     
    end

    def destroy
        @account.destroy
        redirect_to accounts_path
    end

    def update
        if @account.update(account_params)
            redirect_to accounts_path
        else
            render :edit
        end
    end

    private

    def set_account
        if account_signed_in?
            @account = Account.find(params[:id])
        else
            redirect_to new_account_session_path
        end
    end

    def account_params
        params.require(:account).permit(:email, :first_name, :last_name, :username, :role_id)
    end
end




    
    