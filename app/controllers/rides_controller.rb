class RidesController < ApplicationController

include RidesHelper

  def index
    query = Parse::Query.new("Ride")
    query.order_by = "createdAt"
    query.order = :descending
    @rides = query.get
  end

  def show
    query = Parse::Query.new("Ride")
    query.eq("objectId", params[:id])
    @ride = query.get.first
    data = JSON.parse(open(@ride["data"].url ).read)

    @morris_data = data.map {|d| { time: format_time(d["timestamp"]), speed: meters_to_miles(d["speed"]), altitude: meters_to_feet(d["altitude"]) } }
    @leaflet_data = data.map {|d|  [d["lat"], d["long"]] }
  end

end
