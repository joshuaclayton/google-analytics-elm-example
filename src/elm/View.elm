module View exposing (view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onInput)
import Model exposing (Model, Msg(..))
import Router
import Router.View exposing (linkTo, linkToExternal)
import Url


view : Model -> Browser.Document Msg
view model =
    { title = "Google Analytics Elm Example"
    , body = [ navigation model, pageContent model ]
    }


navigation : Model -> Html a
navigation model =
    nav []
        [ Router.View.show model.route
        , ul []
            [ li [] [ linkTo Router.Root [] [ text "Home" ] ]
            , li [] [ linkTo Router.Foo [] [ text "Foo" ] ]
            , li [] [ linkTo Router.Bar [] [ text "Bar" ] ]
            , li [] [ linkTo (Router.Baz "foo") [] [ text "Baz" ] ]
            , li [] [ linkTo (Router.Baz "1") [] [ text "Baz with number" ] ]
            , li [] [ linkToExternal "https://google.com" [] [ text "Google Homepage" ] ]
            ]
        ]


pageContent : Model -> Html Msg
pageContent model =
    case model.route of
        Router.Root ->
            h1 []
                [ text "Welcome!"
                , input [ type_ "text", onInput SetName, value model.name ] []
                ]

        Router.Foo ->
            h1 [] [ text "Foo" ]

        Router.Bar ->
            h1 [] [ text "Bar" ]

        Router.Baz v ->
            h1 [] [ text <| "Baz: " ++ v ]

        Router.NotFound v ->
            h1 [] [ text <| "Uh oh; couldn't find " ++ Url.toString v ]
