module Constants.DefaultSettings exposing (..)

import Material.Elevation as Elevation
import Material.Options as Options exposing(Property)



defaultDayId : Int
defaultDayId =
    -1


defaultBtnElevation : Property a m
defaultBtnElevation =
    Elevation.e6


cssIdHoverRow : String
cssIdHoverRow =
    "row-items__hover"


cssIdHoverTitle : String
cssIdHoverTitle =
    "daily-temperature__hover"


cssIdLineGraphTemperatures : String
cssIdLineGraphTemperatures =
    "lineGraphTemperatures"
