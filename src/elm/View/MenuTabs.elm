module View.MenuTabs exposing (..)

import Material.Color as Color
import Material.Layout as Layout
import Material.Options as Options exposing (cs, css)
import Material.Grid as Grid exposing (align, offset, grid, cell, size, Device(..))

import Html exposing (..)
import Html.Attributes exposing (class, style)

import Model exposing (..)
import Constants.Colors exposing (..)
import View.CardForecast exposing (viewCardForecast)
import View.ButtonQuantity exposing (viewCounter)
import View.DialogQuantity exposing (viewDialogQuantity)

import Graphs.Temperature exposing (..)


viewMenuTabs : Model -> Html Msg
viewMenuTabs model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        , Layout.onSelectTab SelectMenuTab
        , Layout.selectedTab model.selectedMenuTab
        ]
        { header = [ viewHeader model ]
        , drawer = [ ]
        , tabs =
            ( [ text "Pure"
              , text "Hell"
              , text "Counter"
              , text "Dialog"
              ]
            , [ Color.background defaultTabsColor ]
            )
        , main = [ viewTabsBody model ]
        }


viewHeader : Model -> Html Msg
viewHeader model =
    Layout.row
        [ Color.background defaultLayoutColor ]
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
                    , cell [ size All 4
                        , size Tablet 4
                        , size Phone 4
                        ]
                        [ Options.div [cs "graphs" ]
                            [ Options.div[ Options.id "lineGraph1" ]
                                [ ]
                            ]
                        , Options.div [cs "graphs" ]
                            [ Options.div[ Options.id "barGraph1" ]
                                [ ]
                            ]
                        -- , Options.div [cs "graphs" ]
                        --     [ text <| "CardForecast Hover = " ++ toString model.selectedDayIdCardForecast
                        --     , p [] []
                        --     , text <| "Graph Hover = " ++  toString model.selectedDayIdGraph
                        --     ]
                        ]
                    ]
                ]
        1 ->
            div [ class "forecast-card-container" ] (List.map (\x -> text (toString x)) [List.take 8 model.forecast])
        2 ->
            Options.div [ cs "forecast-card-container" ]
                [ viewCounter model
                ]
        3 ->
            Options.div [ cs "forecast-card-container"
                , css "text-align" "center" ]
                [ viewDialogQuantity model
                ]
        _ ->
            text "404"
