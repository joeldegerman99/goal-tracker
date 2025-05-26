module Popover exposing (Position(..), popover)

import Html.Styled exposing (Html, div)
import Html.Styled.Attributes as Attr exposing (id)
import Html.Styled.Events exposing (stopPropagationOn)
import Json.Decode as Decode
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw


{-| Position of the popover relative to its trigger element
-}
type Position
    = Below
    | Above


{-| Configuration for the popover
-}
type alias Config msg =
    { position : Position
    , onClickOutside : msg
    , id : Maybe String
    , content : Html msg
    }


{-| A reusable popover component that is pure and stateless
-}
popover : Config msg -> Html msg
popover config =
    let
        positionStyles =
            case config.position of
                Below ->
                    [ Tw.top_full, Tw.mt_2 ]

                Above ->
                    [ Tw.bottom_full, Tw.mb_2 ]
    in
    div
        ([ Attr.css
            ([ Tw.absolute
             , Tw.left_0
             , Tw.w_64
             , Tw.bg_color TwTheme.white
             , Tw.rounded
             , Tw.shadow_lg
             , Tw.border
             , Tw.p_4
             , Tw.z_10
             ]
                ++ positionStyles
            )
         , stopPropagationOn "click" (Decode.succeed ( config.onClickOutside, True ))
         ]
            ++ (case config.id of
                    Just idValue ->
                        [ id idValue ]

                    Nothing ->
                        []
               )
        )
        [ config.content
        ]
