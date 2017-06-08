module Decoders.Forecast exposing (..)

import Json.Decode as Decode exposing (int, string, float, list, Decoder)
import Json.Decode.Pipeline as Pipe exposing (decode, required)

import Types.Forecast exposing (..)



forecastPath : List String
forecastPath =
    ["query", "results", "channel", "item", "forecast"]


decodeForecastList : Decoder ForecastList
decodeForecastList =
    decode ForecastList
        |> Pipe.requiredAt forecastPath (list decodeForecast)


decodeForecast : Decoder Forecast
decodeForecast =
    decode Forecast
        |> Pipe.requiredAt ["code"] string
        |> Pipe.requiredAt ["date"] string
        |> Pipe.requiredAt ["day"] string
        |> Pipe.requiredAt ["high"] string
        |> Pipe.requiredAt ["low"] string
        |> Pipe.requiredAt ["text"] string
        