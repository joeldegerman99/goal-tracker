module Main exposing (main)

import Browser
import Browser.Dom
import Browser.Events
import Css
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (css, id)
import Html.Styled.Events exposing (onInput, stopPropagationOn)
import Icons
import Json.Decode as Decode
import Popover
import StyledHtml exposing (styledHtml)
import Tailwind.Color exposing (withOpacity)
import Tailwind.Theme as Tw
import Tailwind.Utilities as Tw
import Task


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
    , isAddGoalPopoverVisible : Bool
    , popoverPosition : Popover.Position
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" [] False Popover.Below, Cmd.none )


type Msg
    = UpdateAddGoalTitle String
    | ToggleAddGoalPopover
    | ClikedOutside
    | GotViewportAndButton (Result Browser.Dom.Error ( Browser.Dom.Viewport, Browser.Dom.Element ))
    | ViewportResized Int Int
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateAddGoalTitle title ->
            ( { model | addGoalTitle = title }, Cmd.none )

        ToggleAddGoalPopover ->
            if model.isAddGoalPopoverVisible then
                ( { model | isAddGoalPopoverVisible = False }, Cmd.none )

            else
                ( { model | isAddGoalPopoverVisible = True }
                , Task.map2 Tuple.pair Browser.Dom.getViewport (Browser.Dom.getElement "add-goal-button")
                    |> Task.attempt GotViewportAndButton
                )

        ClikedOutside ->
            ( { model | isAddGoalPopoverVisible = False, addGoalTitle = "" }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

        ViewportResized _ _ ->
            if model.isAddGoalPopoverVisible then
                ( model
                , Task.map2 Tuple.pair Browser.Dom.getViewport (Browser.Dom.getElement "add-goal-button")
                    |> Task.attempt GotViewportAndButton
                )

            else
                ( model, Cmd.none )

        GotViewportAndButton result ->
            case result of
                Ok ( viewport, element ) ->
                    let
                        buttonBottom =
                            element.element.y + element.element.height

                        spaceBelow =
                            viewport.viewport.height - buttonBottom

                        minSpaceNeeded =
                            150

                        -- Minimum space needed for popover
                        position =
                            if spaceBelow < minSpaceNeeded then
                                Popover.Above

                            else
                                Popover.Below
                    in
                    ( { model | popoverPosition = position }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ if model.isAddGoalPopoverVisible then
            Browser.Events.onClick (Decode.succeed ClikedOutside)

          else
            Sub.none
        , Browser.Events.onResize ViewportResized
        ]


view : Model -> Html.Html Msg
view model =
    styledHtml <|
        div [ Attr.css [ Tw.m_8 ] ]
            [ div
                [ css [ Tw.shadow, Tw.rounded, Tw.mt_24 ] ]
                [ section
                    [ css [ Tw.flex, Tw.items_center, Tw.gap_2, Tw.border_b, Tw.p_4 ] ]
                    [ Icons.target (Just <| { width = Just "20", height = Just "20" })
                    , text "Team Goals"
                    , viewBadge "0 / 1 completed"
                    , viewOutlinedBadge "2025-05-29"
                    ]
                , section [ css [ Tw.p_4 ] ]
                    [ viewAddGoalButton model ]
                ]
            ]


viewAddGoalButton : Model -> Html Msg
viewAddGoalButton model =
    div [ css [ Tw.relative ] ]
        [ button
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
            , stopPropagationOn "click" (Decode.succeed ( ToggleAddGoalPopover, True ))
            , id "add-goal-button"
            ]
            [ Icons.plus (Just <| { width = Just "16", height = Just "16" })
            , Html.Styled.text "Add Goal"
            ]
        , if model.isAddGoalPopoverVisible then
            Popover.popover
                { position = model.popoverPosition
                , onClickOutside = NoOp
                , id = Nothing
                , content = viewPopoverContent model
                }

          else
            div [] []
        ]


viewPopoverContent : Model -> Html Msg
viewPopoverContent model =
    div [ Attr.css [ Tw.space_y_4 ] ]
        [ input
            [ Attr.type_ "text"
            , Attr.placeholder "Enter goal title"
            , Attr.value model.addGoalTitle
            , onInput UpdateAddGoalTitle
            , Attr.css
                [ Tw.w_full
                , Tw.border
                , Tw.rounded
                , Tw.px_3
                , Tw.py_2
                , Tw.text_sm
                ]
            ]
            []
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
