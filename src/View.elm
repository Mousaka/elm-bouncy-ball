module View exposing (view)

import Model exposing (Model, BallPos, ViewType(..), Msg(SwitchViewType))
import Html as H exposing (Html, div, text, button)
import Html.Attributes as HA exposing (style)
import Html.Events exposing (onClick)
import Svg.Attributes as SA exposing (..)
import Svg as S exposing (..)
import Window exposing (Size)
import Css as C exposing (..)
import Color
import Game.TwoD.Camera as Camera exposing (Camera)
import Game.TwoD.Render as Render
import Game.TwoD as Game


view : Model -> Html Msg
view model =
    div [ styles [ C.width (pct 100), C.height (pct 100), C.backgroundColor (hex "#F0FFFF"), C.color (rgb 100 100 100), C.fontSize larger ] ] <|
        [ status model, button [ onClick SwitchViewType ] [ H.text "Switch" ], (ball model model.window) ]


ball : Model -> Size -> Html Msg
ball model size =
    let
        ballRad =
            100

        ballWidth =
            (toString (ballRad * 2)) ++ "px"
    in
        case model.viewType of
            Svg_ ->
                svgView model ballWidth

            Webgl ->
                webglView model


svgView pos ballWidth =
    div [ ballPos pos.x pos.y ]
        [ svg [ SA.viewBox "0 0 100 100", SA.width ballWidth ]
            [ S.circle [ cx "50", cy "50", r "49", fill "#0B79CE" ] [] ]
        ]


webglView ballPosition =
    Game.renderCentered { time = 0, camera = Camera.fixedHeight 7 ( 0, 1.5 ), size = ( 800, 600 ) }
        [ Render.rectangle { color = Color.blue, position = ( ballPosition.x, ballPosition.y ), size = ( 0.2, 0.2 ) }
        , Render.rectangle { color = Color.green, position = ( -10, -10 ), size = ( 20, 10 ) }
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
            , toString <| Basics.round model.y
            , " X "
            , toString <| Basics.round model.x
            , " velocity "
            , toString <| Basics.round model.velocity
            , " deltaWindow "
            , toString <| model.windowDelta.height
            ]


styles : List Mixin -> H.Attribute a
styles =
    C.asPairs >> HA.style
