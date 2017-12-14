class HomeController < ApplicationController

  def index
    @month = if params[:Months]
               params[:Months][:month]
             else
               Date.today.month
             end
    @categories = Category.total_up_transactions_by_month @month
  end

  def home_params
    params.permit(Months: :month)
  end
end
