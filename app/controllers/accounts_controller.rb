class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def edit
    @account = Account.find_by(params[:id])
  end

  def update
    account = account_params[:account]
    Account.update(account_params[:id], name: account[:name], amount: account[:amount])
    redirect_to accounts_path
  end

  def create
    if Account.new(account_params[:account]).save
      redirect_to accounts_path
    else
      redirect_to new_account_path
    end
  end

  def account_params
    params.permit(:id, account: %i[name amount])
  end
end
