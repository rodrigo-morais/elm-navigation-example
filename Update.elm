module Update exposing (..)


import Messages exposing (..)
import Models exposing (Model)


{--
  - The update model is obligatory to call main function
--}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)
