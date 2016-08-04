module Update exposing (..)


import Messages exposing (..)
import Models exposing (Model)


{--
  - The update model is obligatory to call main function
--}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    IncrementRoute1Visits ->
      ({ model | visitsRoute1 = model.visitsRoute1 + 1 }, Cmd.none)

    IncrementRoute2Visits ->
      ({ model | visitsRoute2 = model.visitsRoute2 + 1 }, Cmd.none)
