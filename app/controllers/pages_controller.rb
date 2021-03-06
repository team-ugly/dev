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
    @areas = Area.where(area_code: current_user.area_code)

    if current_user.area_code==3|| current_user.area_code==6
      @weather_forecasts = WeatherForecast.where(area_code_forecast: 0)
      @area_code_forecasts = AreaCodeForecast.where(id: 1)
    end
    if current_user.area_code==0|| current_user.area_code==1|| current_user.area_code==2|| current_user.area_code==4
      @weather_forecasts = WeatherForecast.where(area_code_forecast: 1)
      @area_code_forecasts = AreaCodeForecast.where(id: 2)
    end
    if current_user.area_code==5|| current_user.area_code==7
      @weather_forecasts = WeatherForecast.where(area_code_forecast: 2)
      @area_code_forecasts = AreaCodeForecast.where(id: 3)
    end
    if current_user.area_code==9|| current_user.area_code==10|| current_user.area_code==11|| current_user.area_code==12|| current_user.area_code==8
      @weather_forecasts = WeatherForecast.where(area_code_forecast: 3)
      @area_code_forecasts = AreaCodeForecast.where(id: 4)
    end

  end
end
