module Routes exposing (..)



import UrlParser exposing (Parser, oneOf, format, s, parse)
import Navigation
import String


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
    , format Route2 (s "route2")
    , format Route1 (s "route1")
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
  |> String.dropLeft 2
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
