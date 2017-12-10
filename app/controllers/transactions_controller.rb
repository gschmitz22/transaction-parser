class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end
  def import
    Transaction.initialize
    Transaction.import(params[:file])
    redirect_to transactions_path
  end
end
