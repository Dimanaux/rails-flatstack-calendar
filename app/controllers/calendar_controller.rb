class CalendarController < ApplicationController
  before_action :set_year_and_month

  # GET /calendar/1
  def show
    @days = Event.all
    @week_days = ['Sunday', 'Monday', 'T', 'W', 'T', 'F', 'Saturday']
  end

  private

  def set_year_and_month
    today = Date.today
    @year = today.year
    @month = today.month
  end
end
