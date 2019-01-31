module Decoders.Forecast exposing (decodeForecast, decodeForecastList)

import Json.Decode as Decode exposing (Decoder, float, int, list, string)
import Json.Decode.Pipeline as Pipe exposing (decode, required)
import Types.Forecast exposing (..)


decodeForecastList : Decoder ForecastList
decodeForecastList =
    decode ForecastList
        |> Pipe.required "forecasts" (list decodeForecast)


decodeForecast : Decoder Forecast
decodeForecast =
    decode Forecast
        |> Pipe.required "code" string
        |> Pipe.required "date" string
        |> Pipe.required "day" string
        |> Pipe.required "high" string
        |> Pipe.required "low" string
        |> Pipe.required "text" string
