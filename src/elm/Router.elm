module Router exposing
    ( Route(..)
    , parseRoute
    , routeToString
    , routeToTrack
    )

import Url
import Url.Parser as Parser
    exposing
        ( (</>)
        , (<?>)
        , int
        , map
        , oneOf
        , s
        , string
        , top
        )


type Route
    = Root
    | Foo
    | Bar
    | Baz String
    | NotFound Url.Url


parseRoute : Url.Url -> Route
parseRoute url =
    let
        newUrl =
            if useUrlFragments then
                { url
                    | path = Maybe.withDefault "" url.fragment
                    , fragment = Nothing
                }

            else
                url
    in
    newUrl
        |> Parser.parse route
        |> Maybe.withDefault (NotFound url)


routeToString : Route -> String
routeToString route_ =
    let
        prefix =
            if useUrlFragments then
                "/#"

            else
                ""
    in
    prefix ++ routeToTrack route_


useUrlFragments : Bool
useUrlFragments =
    True


routeToTrack : Route -> String
routeToTrack route_ =
    case route_ of
        Root ->
            "/"

        Foo ->
            "/foo"

        Bar ->
            "/bar"

        Baz v ->
            "/baz/" ++ v

        NotFound url ->
            Url.toString url


route : Parser.Parser (Route -> a) a
route =
    oneOf
        [ map Root top
        , map Foo (s "foo")
        , map Bar (s "bar")
        , map Baz (s "baz" </> string)
        ]
