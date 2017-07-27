port module Ports exposing (..)

import Time exposing (Time)

import Model exposing (..)



port sendDataToGraphs : List (List String) -> Cmd msg

port sendDayIdFromCardForest : Int -> Cmd msg

port getDayIdFromGraph : (Int -> msg) -> Sub msg


-- port selectedDay : (Int -> msg) -> Sub msg

-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every (360 * Time.minute) UpdateTime
        -- , selectedDay HooverDay
        , getDayIdFromGraph HoverGraph
        ]
