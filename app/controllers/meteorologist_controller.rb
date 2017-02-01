require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    require "open-uri"
    @street_address_without_spaces = @street_address.gsub(" ","+")
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address_without_spaces
    parsed_data = JSON.parse(open(url).read)
    location = parsed_data["results"][0]["geometry"]["location"]

    @lat = location["lat"].to_f
    @lng = location["lng"].to_f
    require "open-uri"

    url = "https://api.darksky.net/forecast/f01df311d17c6e9a4bc3c304b2b7c5d7/" + @lat.to_s + "," + @lng.to_s
    parsed_data = JSON.parse(open(url).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
