module StyledHtml exposing (..)

import Css exposing (fontFamilies)
import Css.Global
import Html
import Html.Styled exposing (div, toUnstyled)
import Html.Styled.Attributes exposing (css)
import Tailwind.Utilities exposing (globalStyles)


styledHtml : Html.Styled.Html msg -> Html.Html msg
styledHtml html =
    toUnstyled <|
        div [ css [ fontFamilies [ "Geist", "sans-serif" ] ] ]
            [ -- This will give us the standard tailwind style-reset as well as the fonts
              Css.Global.global globalStyles
            , div []
                [ html
                ]
            ]
