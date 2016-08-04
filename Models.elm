module Models exposing (..)

import Routes exposing (Route)


{-
  - This is the model which the app will work
  - The model has to store the route
--}
type alias Model =
  { value : Int,
    route: Route
  }


{--
  - This is the initial model which receives a route and returns a model
--}
initialModel : Route -> Model
initialModel route =
  { value = 0
  , route = route
  }
