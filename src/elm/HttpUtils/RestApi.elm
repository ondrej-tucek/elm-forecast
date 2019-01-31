module HttpUtils.RestApi exposing (fetchForecastData, getForecastData)

import Decoders.Forecast exposing (..)
import Http
import Model exposing (..)
import Types.Forecast exposing (..)



-- API doc
-- https://developer.yahoo.com/weather/documentation.html


getForecastData : Http.Request ForecastList
getForecastData =
    let
        urlApi =
            "https://gist.githubusercontent.com/ondrej-tucek/b150bd0cfa5fd3edfefc426663fd661e/raw/4fd6fad7383eb2927c00f1cebccfedca8036b87b/weather_data.json"
    in
    -- Http.get "http://localhost:8080/weather_data.json" decodeForecastList
    -- Http.get "e:/projects/../elm-weather-app/elm/data.json" decodeForecastList
    Http.get urlApi decodeForecastList


fetchForecastData : Cmd Msg
fetchForecastData =
    Http.send FetchForecastData getForecastData
