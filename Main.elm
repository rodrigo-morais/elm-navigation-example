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


import Html exposing (Html, div, text)
import Html.App
import Messages exposing (Msg(..))


import String
import Navigation
import UrlParser exposing (..)


{--
  - Creating the routes which the app has to respond
--}
type Route
  = Route1
  | Route2
  | NotFound


{--
  - Looking for the route and if it exists will be returned
--}
matchers : Parser (Route -> a) a
matchers =
  oneOf
    [ format Route1 (s "")
    , format Route2 (s "/route2")
    , format Route1 (s "/route1")
    ]


{--
  - Get the location from Navigation when it changes, and after parse it
  - If the location exist in matchers the route will be returned otherwise an error will be
  - How Result works:
    - If we have a success then it return the right side which is our Route
    - If we have a fail it returns the left side which is our String. In this case the String is an error
--}
hashParser : Navigation.Location -> Result String Route
hashParser location =
  location.hash
  |> String.dropLeft 1
  |> parse identity matchers


{--
  - The Navigation package waits for a parser for the current location
--}
parser: Navigation.Parser (Result String Route)
parser =
  Navigation.makeParser hashParser


{--
  - In the end is necessarie to handle with the return of parse
  - It will return a Result with our route or an error
  - In this case we return a route if we can match it or a NotFound route if not
--}
routeFromResult : Result String Route -> Route
routeFromResult result =
  case result of
    Ok route ->
      route

    Err _ ->
      NotFound


{--
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


{--
  - This is the main view that controls all other possible views
--}
view : Model -> Html Msg
view model =
  div []
      [ text "Main view" ]


{--
  - This is the internal pages that are presented following the route matched
--}
internalPage : Model -> Html Msg
internalPage model =
  case model.route of
    Route1 ->
      div []
          [ text "This is Route 1" ]

    Route2 ->
      div []
          [ text "This is Route 2" ]

    NotFound ->
      div []
          [ text "Not found" ]


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
