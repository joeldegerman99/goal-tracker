module Icons exposing (..)

import Svg.Styled exposing (g, path, rect, style, svg)
import Svg.Styled.Attributes exposing (d, fill, height, opacity, stroke, strokeLinecap, transform, viewBox, width)


type alias IconDimensions =
    { width : Maybe String
    , height : Maybe String
    }


task : Maybe IconDimensions -> Svg.Styled.Svg msg
task dimensions =
    let
        dimensionAttrs =
            case dimensions of
                Just dims ->
                    [ Maybe.withDefault "24" dims.width |> width
                    , Maybe.withDefault "24" dims.height |> height
                    ]

                Nothing ->
                    [ width "24"
                    , height "24"
                    ]
    in
    svg
        ([ viewBox "0 0 24 24"
         , fill "currentColor"
         ]
            ++ dimensionAttrs
        )
        [ rect
            [ width "24"
            , height "24"
            , stroke "none"
            , fill "#000000"
            , opacity "0"
            ]
            []
        , g [ transform "matrix(0.47 0 0 0.47 0 0)" ]
            [ path
                [ d "M 13.214844 5.382813 L 7.367188 12.847656 L 4.664063 10.453125 L 3.335938 11.949219 L 7.632813 15.753906 L 14.785156 6.617188 Z M 19 10 L 19 12 L 46 12 L 46 10 Z M 19 24 L 19 26 L 46 26 L 46 24 Z M 19 38 L 19 40 L 46 40 L 46 38 Z"
                , strokeLinecap "round"
                ]
                []
            ]
        ]


target : Maybe IconDimensions -> Svg.Styled.Svg msg
target dimensions =
    let
        dimensionAttrs =
            case dimensions of
                Just dims ->
                    [ Maybe.withDefault "24" dims.width |> width
                    , Maybe.withDefault "24" dims.height |> height
                    ]

                Nothing ->
                    [ width "24"
                    , height "24"
                    ]
    in
    svg (viewBox "0 0 24 24" :: dimensionAttrs)
        [ rect
            [ width "24"
            , height "24"
            , stroke "none"
            , fill "#000000"
            , opacity "0"
            ]
            []
        , g [ transform "matrix(0.83 0 0 0.83 12 12)" ]
            [ path
                [ d "M 16 4 C 9.3844239 4 4 9.3844287 4 16 C 4 22.615571 9.3844239 28 16 28 C 22.615576 28 28 22.615571 28 16 C 28 9.3844287 22.615576 4 16 4 z M 16 6 C 21.534697 6 26 10.465307 26 16 C 26 21.534693 21.534697 26 16 26 C 10.465303 26 6 21.534693 6 16 C 6 10.465307 10.465303 6 16 6 z M 16 8 C 11.593564 8 8 11.593568 8 16 C 8 20.406432 11.593564 24 16 24 C 20.406436 24 24 20.406432 24 16 C 24 11.593568 20.406436 8 16 8 z M 16 10 C 19.325556 10 22 12.674446 22 16 C 22 19.325554 19.325556 22 16 22 C 12.674444 22 10 19.325554 10 16 C 10 12.674446 12.674444 10 16 10 z M 16 12 C 14.75 12 13.685226 12.504756 13.001953 13.273438 C 12.318681 14.042118 12 15.027778 12 16 C 12 16.972222 12.318681 17.957881 13.001953 18.726562 C 13.685226 19.495244 14.75 20 16 20 C 17.25 20 18.314774 19.495244 18.998047 18.726562 C 19.681319 17.957881 20 16.972222 20 16 C 20 15.027778 19.681319 14.042119 18.998047 13.273438 C 18.314774 12.504755 17.25 12 16 12 z M 16 14 C 16.749999 14 17.185226 14.245244 17.501953 14.601562 C 17.81868 14.957882 18 15.472222 18 16 C 18 16.527778 17.81868 17.042119 17.501953 17.398438 C 17.185226 17.754756 16.749999 18 16 18 C 15.250001 18 14.814774 17.754756 14.498047 17.398438 C 14.18132 17.042119 14 16.527778 14 16 C 14 15.472222 14.18132 14.957881 14.498047 14.601562 C 14.814774 14.245245 15.250001 14 16 14 z"
                , strokeLinecap "round"
                , transform "translate(-16, -16)"
                ]
                []
            ]
        ]


plus : Maybe IconDimensions -> Svg.Styled.Svg msg
plus dimensions =
    let
        dimensionAttrs =
            case dimensions of
                Just dims ->
                    [ Maybe.withDefault "24" dims.width |> width
                    , Maybe.withDefault "24" dims.height |> height
                    ]

                Nothing ->
                    [ width "24"
                    , height "24"
                    ]
    in
    svg (viewBox "0 0 24 24" :: dimensionAttrs)
        [ rect
            [ width "24"
            , height "24"
            , stroke "none"
            , fill "#000000"
            , opacity "0"
            ]
            []
        , g [ transform "matrix(0.83 0 0 0.83 12 12)" ]
            [ path
                [ d "M 11 2 L 11 11 L 2 11 L 2 13 L 11 13 L 11 22 L 13 22 L 13 13 L 22 13 L 22 11 L 13 11 L 13 2 Z"
                , strokeLinecap "round"
                , transform "translate(-12, -12)"
                ]
                []
            ]
        ]



-- <svg id='Plus_24' width='24' height='24' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'><rect width='24' height='24' stroke='none' fill='#000000' opacity='0'/>
-- <g transform="matrix(1 0 0 1 12 12)" >
-- <path style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-dashoffset: 0; stroke-linejoin: miter; stroke-miterlimit: 4; fill: rgb(0,0,0); fill-rule: evenodd; opacity: 1;" transform=" translate(-12, -12)" d="M 11 2 L 11 11 L 2 11 L 2 13 L 11 13 L 11 22 L 13 22 L 13 13 L 22 13 L 22 11 L 13 11 L 13 2 Z" stroke-linecap="round" />
-- </g>
-- </svg>
