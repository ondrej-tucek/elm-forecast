module View.ButtonQuantity exposing (..)

import Material.Color as Color
import Material.Button as Button
import Material.Elevation as Elevation
import Material.Typography as Typography
import Material.Options as Options exposing (cs, css, onClick, when)

import Html exposing (..)

import Model exposing (..)


viewButtonQuantity : Model -> Html Msg
viewButtonQuantity model =
    let
        btnBgColor = Color.background (Color.color Color.Indigo Color.S400)
        btnTextColor = Color.text (Color.white)
        quantity = model.quantity
        elevation = Elevation.e6
    in
        Options.div [ css "text-align" "center" ]
            [ Options.div
                [ cs "quantity"
                , Typography.display4
                ]
                [ text <| toString quantity ]
            , p [] []
            , Button.render Mdl [ 0 ] model.mdl
                [ css "margin" "0 5px"
                , elevation
                , Button.raised
                , Button.ripple
                , Button.colored
                , Button.disabled |> when (quantity < 4)
                , btnTextColor |> when (quantity >= 4)
                , btnBgColor |> when (quantity >= 4)
                , onClick (Decrease 3)
                ]
                [ text "-3" ]

            , Button.render Mdl [ 1 ] model.mdl
                [ css "margin" "0 5px"
                , elevation
                , Button.raised
                , Button.ripple
                , Button.colored
                , Button.disabled |> when (quantity < 2)
                , btnTextColor |> when (quantity >= 2)
                , btnBgColor |> when (quantity >= 2)
                , onClick (Decrease 1)
                ]
                [ text "-1" ]

            , Button.render Mdl [ 2 ] model.mdl
                [ css "margin" "0 5px"
                , elevation
                , Button.raised
                , Button.ripple
                , Button.colored
                , btnTextColor
                , btnBgColor
                , onClick (Increase 1)
                ]
                [ text "+1" ]

            , Button.render Mdl [ 3 ] model.mdl
                [ css "margin" "0 5px"
                , elevation
                , Button.raised
                , Button.ripple
                , Button.colored
                , btnTextColor
                , btnBgColor
                , onClick (Increase 3)
                ]
                [ text "+3" ]
            ]
