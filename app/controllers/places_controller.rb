require 'unirest'

class PlacesController < ApplicationController

  def bulk_create
    Place.destroy_all
    @places = fetch_places
    @user = current_user
    @places.each do |place|
      new_place = Place.new(
        place_id: place.PlaceId,
        place: place.PlaceName,
        country_id: place.CountryId,
        region_id: place.RegionId,
        city_id: place.CityId,
        country: place.CountryName,
      )
      new_place.user_id = @user.id
      new_place.save!
    end
    # raise
    redirect_to root_path
  end

  private

  def fetch_places
    response = Unirest.get "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/autosuggest/v1.0/UK/GBP/en-GB/?query=florida",
    headers:{
      "X-RapidAPI-Host" =>  "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com",
      "X-RapidAPI-Key" => "dd277984c2mshb0dba71490fe32fp140ff3jsnbfdc27271a52",
      "Accept": "application/json",
      "Content-Type": "application/json"
    },
    parameters:{
      "country" => "US",
      "currency" => "USD",
      "locale" => "en-US"
    }
    JSON.parse(response.body.to_json, object_class: OpenStruct).Places
  end
end
