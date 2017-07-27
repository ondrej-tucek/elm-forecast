module View.ButtonQuantity exposing (..)

import Material.Color as Color
import Material.Button as Button
import Material.Typography as Typography
import Material.Options as Options exposing (cs, css, onClick, when)

import Html exposing (..)

import Model exposing (..)
import Utils exposing (str2int)
import Constants.Colors exposing (..)
import Constants.DefaultSettings exposing (..)



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

        intLabel =
            str2int label

        (condDisabled, condColor) =
            if (intLabel < 0) then
                (intLabel < diff, intLabel >= diff)
            else if (intLabel > 0) then
                (intLabel - 1 >= diff, intLabel - 1 < diff)
            else
                (False, False)
    in
        Button.render Mdl [ id_ ] model.mdl
            [ cs "quantity-btn--counter"
            , defaultBtnElevation
            , Button.raised
            , Button.ripple
            , Button.colored
            , Button.disabled |> when (condDisabled)
            , Color.text defaultBtnTextColor |> when (condColor)
            , Color.background defaultBtnBgColor |> when (condColor)
            , onClick (ChangeQuantity label)
            ]
            [ text label ]
