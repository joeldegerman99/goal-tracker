module Main exposing (main)

import Browser
import Css
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (css)
import Html.Styled.Events exposing (onClick, onInput)
import Icons
import StyledHtml exposing (styledHtml)
import Tailwind.Color exposing (withOpacity)
import Tailwind.Theme as Tw
import Tailwind.Utilities as Tw


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Goal =
    { id : String
    , title : String
    , completed : Bool
    }


type alias Model =
    { addGoalTitle : String
    , goals : List Goal
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" [], Cmd.none )


type Msg
    = UpdateAddGoalTitle String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateAddGoalTitle title ->
            ( { model | addGoalTitle = title }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html.Html Msg
view _ =
    styledHtml <|
        div [ Attr.css [ Tw.m_8 ] ]
            [ div
                [ css [ Tw.shadow, Tw.rounded ] ]
                [ section
                    [ css [ Tw.flex, Tw.items_center, Tw.gap_2, Tw.border_b, Tw.p_4 ] ]
                    [ Icons.target (Just <| { width = Just "20", height = Just "20" })
                    , text "Team Goals"
                    , viewBadge "0 / 1 completed"
                    , viewOutlinedBadge "2025-05-29"
                    ]
                , section [ css [ Tw.p_4 ] ]
                    [ viewAddGoalButton ]
                ]
            ]


viewAddGoalButton : Html msg
viewAddGoalButton =
    button
        [ Attr.css
            [ Tw.flex
            , Tw.items_center
            , Tw.gap_2
            , Tw.border
            , Tw.rounded
            , Tw.text_xs
            , Tw.px_2
            , Tw.py_1
            , Tw.font_semibold
            , Tw.transition_colors
            , Css.hover [ Tw.bg_color (withOpacity Tw.opacity50 Tw.gray_200) ]
            ]
        ]
        [ Icons.plus (Just <| { width = Just "16", height = Just "16" })
        , Html.Styled.text "Add Goal"
        ]


viewBadge : String -> Html msg
viewBadge text =
    span
        [ Attr.css
            [ Tw.bg_color Tw.gray_100
            , Tw.rounded_full
            , Tw.px_3
            , Tw.py_0_dot_5
            , Tw.text_xs
            , Tw.font_semibold
            ]
        ]
        [ Html.Styled.text text ]


viewOutlinedBadge : String -> Html msg
viewOutlinedBadge text =
    span
        [ Attr.css
            [ Tw.border
            , Tw.border_color Tw.gray_300
            , Tw.bg_color Tw.white
            , Tw.rounded_full
            , Tw.px_3
            , Tw.py_0_dot_5
            , Tw.text_xs
            , Tw.font_semibold
            ]
        ]
        [ Html.Styled.text text ]
