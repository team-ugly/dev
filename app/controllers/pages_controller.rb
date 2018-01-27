class PagesController < ApplicationController
  def index
    @places = Place.all
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow render_to_string(partial: "places/infowindow", locals: { place: place })
      marker.json({name: place.name})
    end

    @weather_informations = WeatherInformation.where(area_code: current_user.area_code)
    @areas = Area.all

    if current_user.area_code==3||6
      @weather_forecasts = WeatherForecast.where(area_code_forecast: 0)
      @area_code_forecasts = AreaCodeForecast.where(id: 1)
    end
    if current_user.area_code==0||1||2||4
      @weather_forecasts = WeatherForecast.where(area_code_forecast: 1)
      @area_code_forecasts = AreaCodeForecast.where(id: 2)
    end
    if current_user.area_code==5||7
      @weather_forecasts = WeatherForecast.where(area_code_forecast: 2)
      @area_code_forecasts = AreaCodeForecast.where(id: 3)
    end
    if current_user.area_code==9||10||11||12
      @weather_forecasts = WeatherForecast.where(area_code_forecast: 3)
      @area_code_forecasts = AreaCodeForecast.where(id: 4)
    end

  end
end
