module Forecast.Temperature exposing (..)

import Types.Forecast exposing (ForecastList)



getList : ForecastList -> String -> List String
getList data str =
    let
        getDailyValue =
            \day ->
                case str of
                    "date" ->
                        day.date
                    "high" ->
                        day.high
                    "low" ->
                        day.low
                    "text" ->
                        day.text
                    _ ->
                        "null"
    in
        List.map getDailyValue data.forecastList


getData : ForecastList -> List String -> List (List String)
getData data listr =
    List.map (getList data) listr
