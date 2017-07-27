module Graphs.Temperature exposing (..)

import Types.Forecast exposing (ForecastList)
import Types.Graphs exposing (GraphData)



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


mapData : ForecastList -> GraphData -> GraphData
mapData forecastList data =
    { data |
        x_date = getList forecastList "date",
        y_high = getList forecastList "high",
        y_low = getList forecastList "low",
        text = getList forecastList "text"
    }
