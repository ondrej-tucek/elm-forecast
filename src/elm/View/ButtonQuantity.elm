module View.ButtonQuantity exposing (..)

import Material.Color as Color
import Material.Button as Button
import Material.Typography as Typography
import Material.Options as Options exposing (cs, css, onClick, when)

import Html exposing (..)

import Model exposing (..)
import Constants.Colors exposing (..)
import Constants.DefaultSettings exposing (..)


btnBgColor : Options.Property c m
btnBgColor = Color.background defaultBtnBgColor

btnTextColor : Options.Property c m
btnTextColor = Color.text defaultBtnTextColor

elevation : Options.Property a m
elevation = defaultBtnElevation


viewCounter : Model -> Html Msg
viewCounter model =
   let
        quantity = model.quantity
        minQuantity = 1
        maxQuantity = 20
    in
        Options.div [ cs "quantity-btn--container" ]
            [ Options.div
                [ cs "quantity__show"
                , Typography.display4
                ]
                [ text <| toString quantity ]
            , p [] []
            , btnCounter model 0 "-3" quantity minQuantity
            , btnCounter model 1 "-1" quantity minQuantity
            , btnCounter model 2 "+1" quantity maxQuantity
            , btnCounter model 3 "+3" quantity maxQuantity
            ]


btnCounter : Model -> Int -> String -> Int -> Int -> Html Msg
btnCounter model id_ label quantity limitQuantity =
    let
        diff =
            limitQuantity - quantity
            
        (condDisabled, condColor) =
            case label of
                "-3" ->
                    (-3 < diff, -3 >= diff)
                "-1" ->
                    (-1 < diff, -1 >= diff)
                "+1" ->
                    (0 >= diff, 0 < diff)
                "+3" ->
                    (2 >= diff, 2 < diff)
                _ -> (False, False)
    in
        Button.render Mdl [ id_ ] model.mdl
            [ cs "quantity-btn--counter"
            , elevation
            , Button.raised
            , Button.ripple
            , Button.colored
            , Button.disabled |> when (condDisabled)
            , btnTextColor |> when (condColor)
            , btnBgColor |> when (condColor)
            , onClick (ChangeQuantity label)
            ]
            [ text label ]
