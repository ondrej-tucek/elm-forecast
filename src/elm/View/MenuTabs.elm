module View.MenuTabs exposing (..)

import Material.Color as Color
import Material.Layout as Layout
import Material.Options as Options exposing (cs, css)

import Html exposing (..)
import Html.Attributes exposing (class, style)

import Model exposing (..)
import View.CardForecast exposing (viewCardForecast)

import Material.Grid as Grid exposing (align, offset, grid, cell, size, Device(..))


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
        [ Layout.title [ css "font-size" "22px" ] [ text "Forecast weather" ]
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
            Options.div [ cs "body-tabs" ]
                [ grid [ ]
                    [ cell
                        [ cs "forecast-card-container"
                        , size All 4
                        , size Tablet 4
                        , size Phone 4
                        ]
                        [ viewCardForecast model ]
                    ]
                ]
        1 ->
            div [ class "forecast-card-container" ] (List.map (\x -> text (toString x)) [List.take 8 model.forecast])
        _ ->
            text "404"
