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

-- getData : ForecastList -> List String -> List (List String)
-- getData data listr =
--     List.map (getList data) listr


-- getData : ForecastList -> List String -> GraphData
-- getData data listr =
--     List.map (getList data) listr

getDate : (ForecastList -> List String)
getDate forecastList =
    getList forecastList "date"

-- type alias GraphData =
--     { x : List String
--     , y : List String
--     , text : List String
--     , selectedDayId : Int --Maybe Int
--     }

-- type alias MyObject =
--   { name: String
--   , displayDate: String
--   , subTitle: String
--   , hashTag: String
--   }

-- port check : MyObject -> Cmd msg
-- Then in the javascript you can just do this:

-- app.ports.check.subscribe(function(myObject) {
--             alert( myObject.name);
--             alert( myObject.displayDate);
--             alert( myObject.subTitle);
--             alert( myObject.hashTag);
--         });