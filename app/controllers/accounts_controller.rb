class AccountsController < ApplicationController
  before_action :set_account, only: [:show]
  before_action :set_from_and_to, only: [:show]

  def show
    @days = Repeat.map_days_to_repeats(@from..@to, @account)
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def accounts_params
    params.require(:account).permit(:id, :year_and_month)
  end

  def set_from_and_to
    today = Date.today
    @from = Date.new(today.year, today.month)
    @from = parse_date(params[:year_and_month]) if params[:year_and_month]
    @to = @from + 34.days
  end

  def parse_date(str)
    year, month = str.split '-'
    Date.new(year.to_i, month.to_i)
  end
end
