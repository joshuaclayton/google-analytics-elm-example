module Update exposing
    ( init
    , subscriptions
    , update
    )

import Analytics
import Browser
import Browser.Navigation
import Model exposing (Model, Msg(..))
import Router
import Url


init : Model.Flags -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model.initial url key, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions =
    always Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange url ->
            let
                newRoute =
                    Router.parseRoute url
            in
            ( { model | route = newRoute }
            , Analytics.trackPageNavigation <| Router.routeToTrack newRoute
            )

        RequestUrl urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Browser.Navigation.pushUrl model.key (Url.toString url)
                    )

                Browser.External href ->
                    ( model, Browser.Navigation.load href )

        SetName newName ->
            ( { model | name = newName }
            , Analytics.trackEvent <| Analytics.UpdateName newName
            )
