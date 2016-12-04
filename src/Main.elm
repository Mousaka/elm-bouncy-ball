module Main exposing (..)

import Model exposing (Model, init)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)
import Html exposing (program)


main : Program Never Model Model.Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
