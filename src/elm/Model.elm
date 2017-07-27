module Model exposing (..)

import Http
import Time exposing (Time)

import Material

import Constants.DefaultSettings exposing (..)
import Types.Graphs exposing (GraphData)
import Types.Forecast exposing (Forecast, ForecastList)




-- Msgs

type alias Mdl =
    Material.Model

type Msg
    = Mdl (Material.Msg Msg)
    | SelectMenuTab Int
    | FetchForecastData (Result Http.Error ForecastList)
    | UpdateTime Time
    | ChangeQuantity String
    -- | HooverDay Int
    | HoverCardForecast Int
    | HoverGraph Int
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
  , selectedDayIdCardForecast : Int
  , selectedDayIdGraph : Int
  , temperaturesData : List (List String)
  -- , graphData : GraphData

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
  , selectedDayIdCardForecast = defaultDayId
  , selectedDayIdGraph = defaultDayId
  , temperaturesData = []
  -- , graphData = Nothing Nothing Nothing Nothing

  -- others..
  , quantity = 1
  }
