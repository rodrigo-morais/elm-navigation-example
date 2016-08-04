{--
- The version 0.17 of Elm bring a new package called Navigation which provides us a way to change the browser location and respond to changes
- The Navigation package gives us a pair of other functionalities. It wrap Html.App and with it is possible to:
  - listen from location change on the browser
  - call our functions when the location change
  - provides a way to change the browser's location
- To help the Navigation package is possible use another package called UrlParse which allows us to create routes
- With these pair of packages together is possible use SPA concept inside Elm

- Initial Render
  - When the application is initialized the Navigation get the current URL and send to parse function: "#/route1" is sent
  - The parse function returns a Route: "#/route1" -> Route1
  - The Navigation send the route to init function: Route1 is sent
  - The init function creates the Model and store the route: initModel = { route = Route1 }
  - The Navigation sends the model to view function: initModel is sent
  - The view function return the HTML renderized

- Location changes
  - When the application is initialized the Navigation get the current URL and send to parse function: "#/route1" is sent
  - The parse function returns a Route: "#/route2" -> Route2
  - The Navigation send the route to urlUpdate function: Route2 is sent
  - The urlUpdate function stores the route in the Model: {initModel | route = Route2 }
  - The Navigation sends the model to view function: initModel is sent
  - The view function return the HTML renderized
  - 
--}


import Html.App


import Navigation
import String


import Routes exposing (..)
import Models exposing (..)
import Messages exposing (..)
import Views exposing (view)


{--
  - This is the init function
--}
init : Result String Route -> (Model, Cmd Msg)
init result =
  let
    currentRoute =
      routeFromResult result

  in
    (initialModel currentRoute, Cmd.none)


{--
  - This is the urlUpdate function
--}
urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
  let
    currentRoute =
      routeFromResult result

  in
    ( { model | route = currentRoute }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


{--
  - The update model is obligatory to call main function
--}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)


{--
  - This is the main function
--}
main : Program Never
main =
  Navigation.program parser
    { init = init
    , view = view
    , update = update
    , urlUpdate = urlUpdate
    , subscriptions = subscriptions
    }
