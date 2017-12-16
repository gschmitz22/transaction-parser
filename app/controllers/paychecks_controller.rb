class PaychecksController < ApplicationController
  def index
    @paychecks = Paycheck.all
  end

  def new
    @paycheck = Paycheck.new
  end

  def edit
    @paycheck = Paycheck.find_by_id(params[:id])
    puts @paycheck.id
0 end

  def create
    if Paycheck.new(paycheck_params[:paycheck]).save
      redirect_to paychecks_path
    else
      redirect_to new_paycheck_path
    end
  end

  def update
    paycheck = paycheck_params[:paycheck]
    Paycheck.update(paycheck_params[:id],
                    date: paycheck[:date],
                    gross_pay: paycheck[:gross_pay],
                    taxes: paycheck[:taxes],
                    roth_401k: paycheck[:roth_401k],
                    tradition_401k: paycheck[:tradition_401k],
                    aspp: paycheck[:aspp],
                    deductions: paycheck[:deductions])
    redirect_to paychecks_path
  end

  def paycheck_params
    params.permit(:id, paycheck: %i[date
                                    gross_pay
                                    taxes
                                    roth_401k
                                    tradition_401k
                                    aspp
                                    deductions])
  end
end
