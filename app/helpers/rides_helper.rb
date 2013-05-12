module RidesHelper

def page_time(time)
  t = Time.iso8601(time).in_time_zone("Pacific Time (US & Canada)")
  t.strftime('%a, %e %b %Y %l:%M %p')
end


end