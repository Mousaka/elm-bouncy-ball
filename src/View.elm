module View exposing (view)

import Model exposing (Model, BallPos, Msg)
import Html as H exposing (Html, div, text)
import Html.Attributes as HA exposing (style)
import Svg.Attributes as SA exposing (..)
import Svg exposing (..)
import Window exposing (Size)
import Maybe exposing (withDefault)
import Css as C exposing (..)


view : Model -> Html Msg
view model =
    div [ styles [ C.width (pct 100), C.height (pct 100), C.backgroundColor (hex "#F0FFFF"), C.color (rgb 100 100 100), C.fontSize larger ] ] <|
        [ status model, (ball model model.window) ]


ball : BallPos Model -> Maybe Size -> Html Msg
ball pos size =
    let
        ballRad =
            100

        ballWidth =
            (toString (ballRad * 2)) ++ "px"
    in
        div [ ballPos pos.x pos.y ]
            [ svg [ SA.viewBox "0 0 100 100", SA.width ballWidth ]
                [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] [] ]
            ]


ballPos : Float -> Float -> H.Attribute a
ballPos x y =
    styles [ C.position (absolute), C.top (px y), C.left (px x) ]


status model =
    div [] <|
        List.map H.text
            [ "Model:"
            , (showWindowSize model.window)
            , "Y"
            , toString model.y
            , "X"
            , toString model.x
            , "velocity"
            , toString model.velocity
            ]


showWindowSize window =
    toString <| withDefault { height = 0, width = 0 } window


styles : List Mixin -> H.Attribute a
styles =
    C.asPairs >> HA.style
