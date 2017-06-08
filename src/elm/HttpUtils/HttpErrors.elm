module HttpUtils.HttpErrors exposing (..)

import Http exposing (..)

-- httpErrorString
-- Pattern match the error response.
-- A MASSIVE thanks to this article:
-- https://becoming-functional.com/http-error-checking-in-elm-fee8c4b68b7b#.6wz3kna56


httpErrorString : Http.Error -> String
httpErrorString error =
    case error of
        Http.BadUrl text ->
            "Bad Url: " ++ text

        Http.Timeout ->
            "Http Timeout"

        Http.NetworkError ->
            "Network Error"

        Http.BadStatus response ->
            "Bad Http Status: " ++ toString response.status.code

        Http.BadPayload message response ->
            "Bad Http Payload: "
                ++ toString message
                ++ " ("
                ++ toString response.status.code
                ++ ")"
