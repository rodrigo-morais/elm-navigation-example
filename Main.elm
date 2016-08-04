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


import Html exposing (Html, div, text, a)
import Html.Attributes exposing (style, href, id)
import Html.App


import Navigation
import String


import Routes exposing (..)


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
      [ menuView
      , internalPage model
      ]


{--
  - A navigator to change between Route1 and Route2
--}
menuView : Html.Html Msg
menuView =
  div [ style [("background-color", "#000000"), ("color", "#FFFFFF")] ]
      [ div []
            [ menuLink "route1" "btnRoute1" "Route1"
            , text " | "
            , menuLink "route2" "btnRoute2" "Route2"
            ]
      ]


menuLink : String -> String -> String -> Html.Html Msg
menuLink href' viewId label =
  let
    href'' =
      if (String.left 3 href') == "/#/" then
        href'
      else
        "/#/" ++ href'

  in
    a [ id viewId
      , href href''
      , style [("text-decoration", "none"), ("color", "#FFFFFF")]
      ]
      [ text label ]


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
  - The Msg which necessary in views and update
--}
type Msg
  = NoOp


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
