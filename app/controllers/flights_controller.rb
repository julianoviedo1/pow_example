class FlightsController < ApplicationController
  def index
    @places = Place.all
    @flights = flight_params ? fetch_flights : []
    @origin = Place.find_by(place_id: params["flight"]["originplace"]).place
    @destination = Place.find_by(place_id: params["flight"]["destinationplace"]).place
  end

  private

  def flight_params
    params.permit(:outboundpartialdate, :destinationplace, :originplace)
  end

  def fetch_flights
    params["flight"].class == NilClass ? date = "#{Date.today}" : date = params["flight"]["outboundpartialdate"]
    response = Unirest.get "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browseroutes/v1.0/US/USD/en-US/SFO-sky/ORD-sky/#{date}",
    headers:{
      "X-RapidAPI-Host" => "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com",
      "X-RapidAPI-Key" => "dd277984c2mshb0dba71490fe32fp140ff3jsnbfdc27271a52",
      "Accept": "application/json",
      "Content-Type": "application/json"
    }
    JSON.parse(response.body.to_json, object_class: OpenStruct)
  end
end
