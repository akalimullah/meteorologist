require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    require "open-uri"
    @street_address_without_spaces = @street_address.gsub(" ","+")
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address_without_spaces
    parsed_data = JSON.parse(open(url).read)
    location = parsed_data["results"][0]["geometry"]["location"]

    @latitude = location["lat"]

    @longitude = location["lng"]

    render("geocoding/street_to_coords.html.erb")
  end
end
