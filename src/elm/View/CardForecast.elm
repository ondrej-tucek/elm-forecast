module View.CardForecast exposing (viewCardForecast)

import Components.CardForecast exposing (currentDayForecast, weeklyForecast)
import Constants.Colors exposing (..)
import Constants.DefaultSettings exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, style)
import Material.Card as Card
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Options as Options exposing (cs, css, nop, onMouseEnter, onMouseLeave, when)
import Material.Typography as Typography
import Model exposing (..)


viewCardForecast : Model -> Html Msg
viewCardForecast model =
    let
        sun =
            defaultSunColor

        rain =
            defaultRainColor

        row ( dayId, day, date, icon, color, high, low ) =
            Options.div
                [ cs "row-items"
                , onMouseEnter (HoverCardForecast dayId)
                , onMouseLeave (HoverCardForecast defaultDayId)
                , Options.id cssIdHoverRow |> when (model.selectedDayIdCardForecast == dayId)
                , Options.id cssIdHoverRow |> when (model.selectedDayIdGraph == dayId)
                ]
                [ Options.div [ cs "item-day" ]
                    [ text day ]
                , Options.div [ cs "item-date" ]
                    [ text date ]
                , Options.div [ cs "item-icon" ]
                    [ i [ class (icon ++ " " ++ color) ] [] ]
                , Options.div [ cs "item-high" ]
                    [ text <| toString high ++ "°" ]
                , Options.div [ cs "item-low" ]
                    [ text <| toString low ++ "°" ]
                ]
    in
    Card.view
        [ Elevation.e3
        , cs "card-forecast"
        ]
        [ Card.title
            [ cs "card-forecast__body" ]
            [ Card.head [ cs "card-forecast__head" ] [ text "Sunnyvale" ]
            , Card.subhead [ cs "card-forecast__subhead" ]
                [ text <|
                    currentDayForecast model "day"
                        ++ " "
                        ++ currentDayForecast model "date"
                        ++ ", "
                        ++ currentDayForecast model "text"
                ]
            , Options.div
                [ cs "card-forecast__daily-temperature"
                , onMouseEnter (HoverCardForecast 0)
                , onMouseLeave (HoverCardForecast defaultDayId)
                , Options.id cssIdHoverTitle |> when (model.selectedDayIdCardForecast == 0)
                , Options.id cssIdHoverTitle |> when (model.selectedDayIdGraph == 0)
                ]
                [ Options.div
                    [ Typography.display4
                    , if currentDayForecast model "high" < "0" then
                        Color.text rain

                      else
                        Color.text sun
                    ]
                    [ text <| currentDayForecast model "high" ]
                , Options.div
                    [ Typography.display1
                    , Color.text rain
                    ]
                    [ text <| currentDayForecast model "low" ]
                ]
            , Options.div [ cs "card-forecast__list-forecast" ]
                (List.map row (weeklyForecast model))
            ]
        ]
