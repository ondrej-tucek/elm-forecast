module Update exposing (..)

import Material

import Model exposing (Model, Msg(..), Mdl)
import HttpUtils.HttpErrors exposing (..)
import HttpUtils.RestApi exposing (..)


-- update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        SelectMenuTab num ->
            { model | selectedMenuTab = num } ! []

        UpdateTime time ->
            { model | lastUpdateTime = time } ! [ fetchForecastData ]

        -- FetchForecastData
        -- on success of 'fetch' set the response on the model
        -- if the reponse was an empty list,
        -- define a notice.
        -- set the isLoading state to False
        FetchForecastData (Ok results) ->
            ( { model
                | forecast = results.forecastList
                , notice = Nothing
              }
            , Cmd.none
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

        -- NoOp
        -- return the current model
        NoOp ->
            ( model, Cmd.none )

