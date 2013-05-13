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
    ride = query.get.first
    data = JSON.parse(open(ride["data"].url ).read)

    @max_speed =  data.map {|d| d["speed"]}.max
    altitude = data.map {|d| d["altitude"]}
    @altitude_change = altitude.max - altitude.min

    @morris_data = data.map {|d| { time: format_time(d["timestamp"]), speed: meters_to_miles(d["speed"]), altitude: meters_to_feet(d["altitude"]) } }.each_slice(2).map(&:first)

  end

end
