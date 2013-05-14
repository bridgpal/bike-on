module RidesHelper

  def page_time(time)
    t = Time.iso8601(time).in_time_zone("Pacific Time (US & Canada)")
    t.strftime('%a, %e %b %Y %l:%M %p')
  end

  def meters_to_miles(meters)
    return (meters * 2.23694).round(2)
  end

  def meters_to_feet(meters)
    return (meters * 3.28084).round(2)
  end

  def meters_in_miles(meters)
    return (meters * 0.000621371).round(2)
  end

  def format_time(time)
    Time.at(time.to_i).in_time_zone("Pacific Time (US & Canada)").strftime("%m-%e-%y %H:%M:%S")
  end
end