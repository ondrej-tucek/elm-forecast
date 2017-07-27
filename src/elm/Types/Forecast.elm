module Types.Forecast exposing (..)



type alias ForecastList =
    { forecastList : List Forecast
    }


type alias Forecast =
    { code : String
    , date : String
    , day : String
    , high : String
    , low : String
    , text : String
    }
