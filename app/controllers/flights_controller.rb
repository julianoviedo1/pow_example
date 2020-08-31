class FlightsController < ApplicationController
  def index
    @places = Place.all
    @flights = flight_params ? fetch_flights : []

    # Caso: entrar en /flights sin busqueda 
    # Tira error
    # Solución:
    # Prevenir resultado Nil para @flights
   
    unless @flights != NilClass
      @origin = @flights.Places[0]["Name"]
      @destination = @flights.Places[1]["Name"]
    end
  end

  private

  def flight_params
    params.permit(:outboundpartialdate, :destinationplace, :originplace)
  end

  # Metodos como este hay que guardar dentro de un Service o una clase ruby
  # Porque?
  # 1) Es probable que un request a API lo utilizarias en otros lados de tu App
  # 2) Evitas que tu controlador se convierta en un FAT Controller (código mas limpio y legible)
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
