module Types.Forecast exposing (Forecast, ForecastList)


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
