module Types.Graphs exposing (..)



type alias GraphData =
    { x : Maybe (List String)
    , y : Maybe (List String)
    , text : Maybe (List String)
    , selectedDayId : Maybe Int
    }
