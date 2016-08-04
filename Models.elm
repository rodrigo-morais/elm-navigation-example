modules Models exposing (..)


{-
  - This is the model which the app will work
  - The model has to store the route
--}
type alias Model =
  { value : Int,
    route: Route
  }
