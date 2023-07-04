module ParkingsHelper
  def format_time(time_string)
    return if not time_string

    time = Time.parse(time_string)
    time.strftime("%H:%M")
  end

  def format_cost(cost)
    number_with_precision(cost, precision: 2)
  end

  def format_date(date_string)
    date = Date.parse(date_string)
    date.strftime("%d/%m/%Y")
  end
end
