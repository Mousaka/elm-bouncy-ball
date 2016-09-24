module Update exposing (update)

import Model exposing (Model, Ball, Msg(..))
import Time exposing (Time)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateHelp msg model, Cmd.none )


updateHelp : Msg -> Model -> Model
updateHelp msg model =
    case msg of
        Resize s ->
            { model | window = (Just s) }

        TimeUpdate t ->
            physics t model

        FetchErrors _ ->
            model


physics : Time -> Model -> Model
physics dt model =
    let
        y' =
            model.y

        v' =
            model.velocity + 0.1

        direction =
            model.direction

        size' =
            Maybe.withDefault { width = 0, height = 0 } model.window

        height' =
            size'.height

        newY =
            if y' > height' - 200 then
                height' - 200
            else
                y' + v' * dt
    in
        case y' < height' - 200.0 of
            True ->
                { model | y = newY, velocity = v' }

            False ->
                model
