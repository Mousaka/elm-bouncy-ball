module Subscriptions exposing (subscriptions)

import Model exposing (Model, Msg(Resize, TimeUpdate))
import Window exposing (Size, resizes)
import AnimationFrame
import Time exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ AnimationFrame.diffs TimeUpdate
        , resizes Resize
        ]
