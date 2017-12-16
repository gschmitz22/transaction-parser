class HomeController < ApplicationController

  def index
    @month = if params[:Months]
               params[:Months][:month]
             else
               Date.today.month
             end
    @categories = Category.monthly_totals(@month.to_i)
    @transactions = Transaction.find_by_month(@month.to_i)
    @paychecks = Paycheck.find_by_month(@month.to_i)
  end

  def home_params
    params.permit(Months: :month)
  end
end
