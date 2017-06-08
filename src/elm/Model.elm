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

  -- others..
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

  -- others..
  }


-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (360 * Time.minute) UpdateTime
