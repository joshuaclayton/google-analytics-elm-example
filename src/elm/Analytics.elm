port module Analytics exposing (Event(..), trackEvent, trackPageNavigation)

import Json.Decode as Decode
import Json.Encode as Encode


port trackAnalytics : Decode.Value -> Cmd a


type Event
    = NavigateToPage String
    | UpdateName String


trackEvent : Event -> Cmd a
trackEvent =
    trackAnalytics << analyticsPayload


trackPageNavigation : String -> Cmd a
trackPageNavigation =
    trackEvent << NavigateToPage


analyticsPayload : Event -> Decode.Value
analyticsPayload event =
    Encode.object
        [ ( "action", Encode.string <| eventToAction event )
        , ( "data", eventToPayload event )
        ]


eventToAction : Event -> String
eventToAction event =
    case event of
        NavigateToPage _ ->
            "navigateToPage"

        UpdateName _ ->
            "updateName"


eventToPayload : Event -> Encode.Value
eventToPayload event =
    case event of
        NavigateToPage url ->
            Encode.string url

        UpdateName name ->
            Encode.string name
