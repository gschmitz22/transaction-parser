class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def import_view; end

  def import
    Transaction.import(params[:file])
    redirect_to transactions_path
  end
end
