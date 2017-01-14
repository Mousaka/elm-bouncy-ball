module Model exposing (Model, Ball, BallPos, ViewType(..), init, Msg(..))

import Window exposing (Size, size)
import Task exposing (perform)
import Time exposing (Time)


type Msg
    = Resize Size
    | FetchErrors String
    | TimeUpdate Time
    | SwitchViewType


type ViewType
    = Webgl
    | Svg_


type alias Ball a =
    { a | x : Int, y : Int, velocity : Float, window : Size }


type alias BallPos a =
    { a | x : Float, y : Float }


type alias Model =
    { x : Float
    , y : Float
    , velocity : Float
    , direction : Float
    , window : Size
    , windowDelta : Size
    , viewType : ViewType
    }


init : ( Model, Cmd Msg )
init =
    ( { x = 300
      , y = 100
      , velocity = 0.0
      , direction = 1
      , window = { width = 0, height = 0 }
      , windowDelta = { width = 0, height = 0 }
      , viewType = Svg_
      }
    , windowSizeCmd
      --fetching initial window size
    )


windowSize : Task.Task x Size
windowSize =
    size


windowSizeCmd : Cmd Msg
windowSizeCmd =
    perform Resize windowSize
