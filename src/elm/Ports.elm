port module Ports exposing (..)

import Time exposing (Time)

import Model exposing (..)
import Types.Graphs exposing (GraphData)



port sendDataToGraphs : GraphData -> Cmd msg

port sendDayIdFromCardForest : Int -> Cmd msg

port getDayIdFromGraph : (Int -> msg) -> Sub msg


-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every (360 * Time.minute) UpdateTime
        , getDayIdFromGraph HoverGraph
        ]
