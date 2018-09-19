module Model exposing
    ( Flags
    , Model
    , Msg(..)
    , initial
    )

import Browser
import Browser.Navigation
import Router
import Url


type alias Model =
    { key : Browser.Navigation.Key, route : Router.Route, name : String }


type Msg
    = UrlChange Url.Url
    | RequestUrl Browser.UrlRequest
    | SetName String


type alias Flags =
    ()


initial : Url.Url -> Browser.Navigation.Key -> Model
initial url key =
    { key = key, route = Router.parseRoute url, name = "" }
