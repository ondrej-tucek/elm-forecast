module Utils exposing (..)

import Char exposing (toUpper)
import String exposing (
    toInt,
    cons,
    uncons
    )



str2int : String -> Int
str2int str =
    Result.withDefault 0 (toInt str)


toSentenceCase : String -> String
toSentenceCase word =
    uncons word
        |> Maybe.map (\( head, tail ) -> cons (toUpper head) tail)
        |> Maybe.withDefault ""
