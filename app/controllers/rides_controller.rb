class RidesController < ApplicationController

include RidesHelper

  def index
    query = Parse::Query.new("Ride")
    query.order_by = "createdAt"
    query.order = :descending
    query.include = "creator"
    @rides = query.get
    @max_speed = @rides.map{|r| r["maxSpeed"]}.max.round(2).to_s + " mph"
    @max_distance = meters_in_miles(@rides.map{|r| r["distance"]}.max.round(2)).to_s + " miles"

  end


  def show
    query = Parse::Query.new("Ride")
    query.eq("objectId", params[:id])
    @ride = query.get.first
    data = JSON.parse(open(@ride["data"].url ).read)
    @morris_data = data.map {|d| { time: format_time(d["timestamp"]), speed: meters_to_miles(d["speed"]), altitude: meters_to_feet(d["altitude"]) } }
    @leaflet_data = data.map {|d|  [d["lat"], d["long"]] }
    respond_to do |format|
      format.html
      format.json do

          @d = data.map {|d| { title: format_time(d["timestamp"]), value: meters_to_miles(d["speed"])} }
          @panic = { graph: { title: "Ride Data", datasequences: [{title: "Speed", type: "line", datapoints: @d}] }}
          render :json => @panic
      end
    end

  end


  def speed

    #refactor this
    query = Parse::Query.new("Ride")
    query.eq("objectId", params[:id])
    @ride = query.get.first
    data = JSON.parse(open(@ride["data"].url ).read)
    @morris_data = data.map {|d| { time: format_time(d["timestamp"]), speed: meters_to_miles(d["speed"]), altitude: meters_to_feet(d["altitude"]) } }
  end
end
