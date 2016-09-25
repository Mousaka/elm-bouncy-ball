module View exposing (view)

import Model exposing (Model, BallPos, Msg)
import Html as H exposing (Html, div, text)
import Html.Attributes as HA exposing (style)
import Svg.Attributes as SA exposing (..)
import Svg exposing (..)
import Window exposing (Size)
import Css as C exposing (..)


view : Model -> Html Msg
view model =
    div [ styles [ C.width (pct 100), C.height (pct 100), C.backgroundColor (hex "#F0FFFF"), C.color (rgb 100 100 100), C.fontSize larger ] ] <|
        [ status model, (ball model model.window) ]


ball : BallPos Model -> Size -> Html Msg
ball pos size =
    let
        ballRad =
            100

        ballWidth =
            (toString (ballRad * 2)) ++ "px"
    in
        div [ ballPos pos.x pos.y ]
            [ svg [ SA.viewBox "0 0 100 100", SA.width ballWidth ]
                [ circle [ cx "50", cy "50", r "49", fill "#0B79CE" ] [] ]
            ]


ballPos : Float -> Float -> H.Attribute a
ballPos x y =
    styles [ C.position (absolute), C.top (px y), C.left (px x) ]


status model =
    div [] <|
        List.map H.text
            [ "Model:"
            , (toString model.window)
            , " Y "
            , toString <| round model.y
            , " X "
            , toString <| round model.x
            , " velocity "
            , toString <| round model.velocity
            , " deltaWindow "
            , toString <| model.windowDelta.height
            ]


styles : List Mixin -> H.Attribute a
styles =
    C.asPairs >> HA.style
