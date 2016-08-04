module Models exposing (..)

import Routes exposing (..)


{-
  - This is the model which the app will work
  - The model has to store the route
--}
type alias Model =
  { visitsRoute1 : Int
  , visitsRoute2 : Int
  , route: Route
  }


{--
  - This is the initial model which receives a route and returns a model
--}
initialModel : Route -> Model
initialModel route =
  let
    initVisits r =
      if route == r then 1 else 0

  in
    { visitsRoute1 = initVisits Route1 
    , visitsRoute2 = initVisits Route2
    , route = route
    }
