module CalendarHelper
  def week_days
    %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
  end

  def get_month(days_range)
    date = days_range.keys.first
    Date.new(date.year, date.month)
  end

  def month_format(date)
    date.strftime '%B %Y'
  end

  def next_month(date)
    link_month_format(get_month(date) + 1.month)
  end

  def previous_month(date)
    link_month_format(get_month(date) - 1.month)
  end

  def link_month_format(date)
    date.strftime '%Y-%m'
  end
end
