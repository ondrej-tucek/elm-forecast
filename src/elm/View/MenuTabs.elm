module View.MenuTabs exposing (..)

import Material.Color as Color
import Material.Layout as Layout
import Material.Options as Options exposing (cs, css)

import Html exposing (..)
import Html.Attributes exposing (class, style)

import Model exposing (..)
import View.CardForecast exposing (viewCardForecast)


viewMenuTabs : Model -> Html Msg
viewMenuTabs model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        , Layout.onSelectTab SelectMenuTab
        , Layout.selectedTab model.selectedMenuTab
        ]
        { header = [ viewHeader model ]
        , drawer = []
        , tabs =
            ( [ text "Pure"
              , text "Hell"
              ]
            , [ Color.background (Color.color Color.Teal Color.S400) ]
            )
        , main = [ viewTabsBody model ]
        }


viewHeader : Model -> Html Msg
viewHeader model =
    Layout.row
        [ Color.background (Color.color Color.Teal Color.S500) ]
        [ Layout.title [ css "font-size" "28px" ] [ text "Forecast weather" ]
        , Layout.spacer
        , Layout.navigation []
            [ Layout.link
                [ Layout.href "https://github.com/ondrej-tucek/elm-forecast" ]
                [ text "github" ]
            ]
        ]


viewTabsBody : Model -> Html Msg
viewTabsBody model =
    case model.selectedMenuTab of
        0 ->
            div []
                [
                  div [ class "body-tabs" ] [ viewCardForecast model ]
                ]

        1 ->
            div [ class "body-tabs" ] (List.map (\x -> text (toString x)) [List.take 8 model.forecast])

        _ ->
            text "404"


