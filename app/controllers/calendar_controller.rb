class CalendarController < ApplicationController
  before_action :set_year_and_month

  # GET /calendar/1
  def show
    @events = Event.all
  end

  private

  def set_year_and_month
    today = Date.today
    @year = today.year
    @month = today.month
  end
end
