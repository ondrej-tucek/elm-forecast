module View.MenuTabs exposing (..)

import Material.Color as Color
import Material.Button as Button
import Material.Dialog as Dialog
import Material.Layout as Layout
import Material.Elevation as Elevation
import Material.Options as Options exposing (cs, css)

import Html exposing (..)
import Html.Attributes exposing (class, style)

import Model exposing (..)
import View.CardForecast exposing (viewCardForecast)
import View.ButtonQuantity exposing (viewButtonQuantity)
import View.DialogQuantity exposing (viewDialogQuantity)

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
              , text "Counter"
              , text "Dialog"
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
        2 ->
            Options.div [ cs "forecast-card-container" ]
                [ viewButtonQuantity model
                ]
        3 ->
            Options.div [ cs "forecast-card-container"
                , css "text-align" "center" ]
                [ viewDialogQuantity model
                ]
        _ ->
            text "404"
