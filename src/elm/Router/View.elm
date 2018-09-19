module Router.View exposing (linkTo, linkToExternal, show)

import Html exposing (Html, a, text)
import Html.Attributes exposing (href)
import Router


linkTo : Router.Route -> List (Html.Attribute a) -> List (Html a) -> Html a
linkTo route attributes =
    a ([ href <| Router.routeToString route ] ++ attributes)


linkToExternal : String -> List (Html.Attribute a) -> List (Html a) -> Html a
linkToExternal url attributes =
    a ([ href url ] ++ attributes)


show : Router.Route -> Html a
show route =
    text <| "The current URL is " ++ Router.routeToString route
