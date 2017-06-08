module HttpUtils.RestApi exposing (..)

import Http

import Types.Forecast exposing (..)
import Decoders.Forecast exposing (..)
import Model exposing (..)


-- API doc
-- https://developer.yahoo.com/weather/documentation.html
getForecastData : Http.Request ForecastList
getForecastData =
    let
--     woeid=796166 Plzne
        w =
            "796166"

        urlApi =
                "https://query.yahooapis.com/v1/public/yql"
                    ++ "?q=select * from weather.forecast where woeid="
                    ++ w
                    ++ " and u='c'"
                    ++ "&format=json"
    in
        -- Http.get "http://localhost:8080/data.json" decodeForecastData
        -- Http.get "e:/projects/../elm-weather-app/elm/data.json" usersDecoder
        Http.get urlApi decodeForecastList


fetchForecastData : Cmd Msg
fetchForecastData =
    Http.send FetchForecastData getForecastData
