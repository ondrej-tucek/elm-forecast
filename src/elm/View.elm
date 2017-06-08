module View exposing (view)

import Html exposing (..)

import Model exposing (Model, Msg(..))
import View.MenuTabs exposing (viewMenuTabs)



view : Model -> Html Msg
view model =
    viewMenuTabs model
