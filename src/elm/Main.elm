module Main exposing (..)

import Html

import View exposing (view)
import Update exposing (update)
import Ports exposing (subscriptions)
import Model exposing (Model, Msg(..), model)
import HttpUtils.RestApi exposing (fetchForecastData)



main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.batch [ fetchForecastData ] )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
