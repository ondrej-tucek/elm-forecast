module Model exposing (..)

import Time exposing (Time)
import Http

import Material

import Types.Forecast exposing (Forecast, ForecastList)



-- Msgs

type alias Mdl =
    Material.Model

type Msg
    = Mdl (Material.Msg Msg)
    | SelectMenuTab Int
    | FetchForecastData (Result Http.Error ForecastList)
    | UpdateTime Time
    | Increase Int
    | Decrease Int
    | TemperaturesData (List (List String))
    | NoOp


-- Model
-- define a structure for the Model

type alias Model =
  { -- mdl components
    mdl : Mdl
  , selectedMenuTab : Int

  -- Forecast
  , lastUpdateTime : Time
  , forecast : List Forecast
  , notice : Maybe String
  , temperaturesData : List (List String)

  -- others..
  , quantity : Int
  }


-- model
-- the state of the app

model : Model
model =
  { -- mdl components
    mdl = Material.model
  , selectedMenuTab = 0

    -- Forecast
  , lastUpdateTime = 0.0
  , forecast = []
  , notice = Nothing
  , temperaturesData = []

  -- others..
  , quantity = 1
  }


-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (360 * Time.minute) UpdateTime
