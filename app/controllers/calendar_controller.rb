class CalendarController < ApplicationController
  before_action :set_from_and_to

  # GET /calendar/1
  def show
    @days = Repeat.map_days_to_repeats(@from..@to)
  end

  private

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

  def calendar_params
    params.require(:calendar).permit(:year_and_month)
  end
end
