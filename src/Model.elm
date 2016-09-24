module Model exposing (Model, Ball, BallPos, init, Msg(..))

import Window exposing (Size, size)
import Task exposing (perform)
import Time exposing (Time)


type Msg
    = Resize Size
    | FetchErrors String
    | TimeUpdate Time


type alias Ball a =
    { a | x : Int, y : Int, velocity : Float, window : Maybe Size }


type alias BallPos a =
    { a | x : Float, y : Float }


type alias Model =
    { x : Float
    , y : Float
    , velocity : Float
    , direction : Float
    , window : Maybe Size
    }


init : ( Model, Cmd Msg )
init =
    ( { x = 300
      , y = 100
      , velocity = 0.1
      , direction = 1
      , window = Nothing
      }
    , windowSizeCmd
      --fetching initial window size
    )


windowSize : Task.Task x Size
windowSize =
    size


windowSizeCmd : Cmd Msg
windowSizeCmd =
    perform FetchErrors Resize windowSize
