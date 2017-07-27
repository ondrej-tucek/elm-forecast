module Update exposing (..)

import Material
import Material.Helpers exposing (cmd)

import Model exposing (Model, Msg(..), Mdl)
import HttpUtils.HttpErrors exposing (..)
import HttpUtils.RestApi exposing (..)

import Ports exposing (..)
import Graphs.Temperature exposing (..)



-- update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        SelectMenuTab num ->
            let
                model_ =
                    { model | selectedMenuTab = num }

                cmd_ =
                    if num == 0 then sendDataToGraphs model.temperaturesGraphData else Cmd.none
            in
                ( model_, cmd_ )

        UpdateTime time ->
            { model | lastUpdateTime = time } ! [ fetchForecastData ]

        FetchForecastData (Ok results) ->
        let
            setData = mapData results model.temperaturesGraphData
        in
            ( { model
                | forecast = results.forecastList
                , notice = Nothing
                , temperaturesGraphData = setData
              }
            , ( cmd
                <| GraphDataMsg setData
              )
            )

        FetchForecastData (Err err) ->
            ( { model
                | forecast = []
                , notice = Just (httpErrorString err)
              }
            , Cmd.none
            )

        ChangeQuantity str ->
            let
                str2int =
                    Result.withDefault 0 (String.toInt str)
            in
                ( { model | quantity = model.quantity + str2int }, Cmd.none )

        HoverCardForecast day_ ->
            ( { model | selectedDayIdCardForecast = day_  }, sendDayIdFromCardForest day_ )

        HoverGraph day_ ->
            ( { model | selectedDayIdGraph = day_  }, Cmd.none )

        GraphDataMsg data_ ->
            ( { model | temperaturesGraphData = data_ }, sendDataToGraphs data_ )

        NoOp ->
            ( model, Cmd.none )
