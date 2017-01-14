module Update exposing (update)

import Model exposing (Model, Ball, ViewType(..), Msg(..))
import Time exposing (Time)
import Window exposing (Size)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateHelp msg model, Cmd.none )


updateHelp : Msg -> Model -> Model
updateHelp msg model =
    case msg of
        Resize size ->
            resize model size

        TimeUpdate t ->
            physics t model

        FetchErrors _ ->
            model

        SwitchViewType ->
            { model
                | viewType =
                    case model.viewType of
                        Svg_ ->
                            Webgl

                        Webgl ->
                            Svg_
            }


resize : Model -> Size -> Model
resize model size =
    let
        sizeDt =
            { width = size.width - model.window.width, height = size.height - model.window.height }
    in
        { model | window = size, windowDelta = sizeDt }


resetWindowDt : Model -> Model
resetWindowDt model =
    { model | windowDelta = { width = 0, height = 0 } }


physics : Time -> Model -> Model
physics dt model =
    model |> hitBottom dt |> windDrag dt |> applyGravity dt |> resetWindowDt


hitBottom : Time -> Model -> Model
hitBottom dt model =
    let
        height =
            toFloat (model.window.height - 200)
    in
        case model.y >= height of
            True ->
                bounce dt model

            False ->
                model


windDrag : Time -> Model -> Model
windDrag dt model =
    let
        drag =
            model.velocity * dt * 0.0005
    in
        { model | velocity = model.velocity - drag }


bounce : Time -> Model -> Model
bounce dt model =
    let
        y_ =
            if model.velocity < 0.2 then
                toFloat (model.window.height - 200)
            else
                toFloat (model.window.height - 200 - 1)

        bottomSpeed =
            toFloat model.windowDelta.height * 0.2
    in
        { model
            | y = y_
            , velocity = bottomSpeed + (model.velocity * -0.7)
        }


applyGravity : Time -> Model -> Model
applyGravity dt model =
    let
        v_ =
            model.velocity + 0.1

        newY =
            model.y + v_ * dt
    in
        { model | y = newY, velocity = v_ }
