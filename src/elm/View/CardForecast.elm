module View.CardForecast exposing (..)

import Material.Card as Card
import Material.Elevation as Elevation
import Material.Color as Color
import Material.Options as Options exposing (cs, css)
import Material.Typography as Typography

import Html exposing (..)
import Html.Attributes exposing (class, style)

import Model exposing (..)
import Components.CardForecast exposing (currentDayForecast, weeklyForecast)



viewCardForecast : Model -> Html Msg
viewCardForecast model =
    let
        sun =
        Color.color Color.Amber Color.S500

        rain =
        Color.color Color.LightBlue Color.S500

        row (day, date, icon, color, high, low) =
            Options.div
                [ cs "row-items" ]
                [ Options.span [ cs "item-day" ]
                    [ text day ]
                , Options.span [ cs "item-date" ]
                    [ text date ]
                , Options.span [ cs "item-icon" ]
                    [ i [ class (icon ++ " " ++ color) ] [ ] ]
                , Options.span [ cs "item-high" ]
                    [ text <| toString high ++ "°" ]
                , Options.span [ cs "item-low" ]
                        [ text <| toString low ++ "°" ]
                ]
    in
        Card.view
        [ Elevation.e3
        -- , cs "card-forecast"
        , css "width" "288px"
        ]
        [ Card.title
            [ cs "card-forecast__body" ]
            [ Card.head [ cs "card-forecast__head" ] [ text "Pilsen" ]
            , Card.subhead [ cs "card-forecast__subhead" ]
                [ text
                    <| currentDayForecast model "day"
                        ++ " " ++
                        currentDayForecast model "date"
                        ++ ", " ++
                        currentDayForecast model "text"
                ]
            , Options.div
                [ cs "card-forecast__daily-temperature" ]
                [ Options.span
                    [ Typography.display4
                    , if (currentDayForecast model "high") < "0" then
                        Color.text rain
                      else
                        Color.text sun
                    ]
                    [ text <| currentDayForecast model "high" ]
                , Options.span
                    [ Typography.display1
                    , Color.text rain
                    ]
                    [ text <| currentDayForecast model "low" ]
                ]
            , Options.div [ cs "card-forecast__list-forecast" ]
                (List.map row (weeklyForecast model))
            ]
        ]
