module Main exposing (..)

import Model exposing (Model, init)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)
import Html.App exposing (program)


main : Program Never
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
