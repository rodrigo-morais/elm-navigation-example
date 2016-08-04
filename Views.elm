module Views exposing (..)


import Html exposing (Html, div, text, a)
import Html.Attributes exposing (style, href, id)


import String


import Messages exposing (..)
import Routes exposing (..)
import Models exposing (Model)


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
  div [ style [ ("background-color", "#000000")
              , ("color", "#FFFFFF")
              ]
      ]
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
