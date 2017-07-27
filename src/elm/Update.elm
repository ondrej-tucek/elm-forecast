module Update exposing (..)

import Material
import Material.Helpers exposing (cmd)

import Model exposing (Model, Msg(..), Mdl)
import HttpUtils.HttpErrors exposing (..)
import HttpUtils.RestApi exposing (..)

import Ports exposing (..)
import Forecast.Temperature exposing (..)
import Constants.DefaultSettings exposing (..)



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
                    if num == 0 then sendDataToGraphs model.temperaturesData else Cmd.none
            in
                ( model_, cmd_ )

        UpdateTime time ->
            { model | lastUpdateTime = time } ! [ fetchForecastData ]

        -- FetchForecastData
        -- on success of 'fetch' set the response on the model
        -- if the reponse was an empty list,
        -- define a notice.
        -- set the isLoading state to False
        FetchForecastData (Ok results) ->
        let
            getResults = getData results [ "date", "high", "low", "text" ]
        in
            ( { model
                | forecast = results.forecastList
                , notice = Nothing
                , temperaturesData = getResults
              }
            , ( cmd
                <| TemperaturesData getResults
              )
            )

        -- FetchFail
        -- on Http fail set :
        -- the reponse as 'notice'
        -- the isLoading state to False
        -- result to Nothing
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

        TemperaturesData data_ ->
            ( { model | temperaturesData = data_ }, (sendDataToGraphs data_) )

        -- NoOp
        -- return the current model
        NoOp ->
            ( model, Cmd.none )

-- temperaturesData <| getData model ["date", "high", "low", "text"]