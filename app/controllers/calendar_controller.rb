class CalendarController < ApplicationController
  before_action :set_year_and_month

  # GET /calendar/1
  def show
    @repeats = Repeat.all
  end

  private

  def set_year_and_month
    today = Date.today
    @date = today
  end
end
