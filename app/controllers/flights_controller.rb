class FlightsController < ApplicationController
  def index
    @places = Place.all
    @flights = params ? fetch_flights : []
  end

  private

  def flight_params
    # params.require(:flight).permit(:outboundpartialdate, :destinationplace, :originplace)
  end

  def fetch_flights
    response = Unirest.get "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browseroutes/v1.0/US/USD/en-US/SFO-sky/ORD-sky/2020-09-21",
    headers:{
      "X-RapidAPI-Host" => "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com",
      "X-RapidAPI-Key" => "dd277984c2mshb0dba71490fe32fp140ff3jsnbfdc27271a52",
      "Accept": "application/json",
      "Content-Type": "application/json"
    }
    JSON.parse(response.body.to_json, object_class: OpenStruct)
  end
end
