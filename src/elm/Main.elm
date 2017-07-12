module Main exposing (..)

import Html

import Model exposing (Model, Msg(..), model, subscriptions)
import View exposing (view)
import Update exposing (update)
import HttpUtils.RestApi exposing (fetchForecastData)



main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.batch [ fetchForecastData ] )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
