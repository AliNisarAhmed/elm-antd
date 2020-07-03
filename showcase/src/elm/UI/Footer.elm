module UI.Footer exposing (footer)

import Css exposing (..)
import Html.Styled as Styled exposing (div, text)
import Html.Styled.Attributes as A exposing (css, href)
import UI.Typography exposing (commonTextStyles)


footerStyles : List Css.Style
footerStyles =
    commonTextStyles
        ++ [ height (px 100)
           , color (hex "#fff")
           , backgroundColor (hex "#000")
           , marginTop (px 100)
           , paddingTop (px 50)
           , paddingRight (px 50)
           , paddingLeft (px 50)
           , textAlign center
           ]


footer : Styled.Html msg
footer =
    Styled.footer [ css footerStyles ]
        [ div
            []
            [ text "Made with ❤ by supermacro, "
            , Styled.a
                [ href "https://github.com/supermacro/elm-antd/issues"
                , A.target "_blank"
                , css
                    [ color (hex "#fff" )
                    , visited
                        [ color (hex "#fff" ) ]
                    ]
                ]
                [ text "and you?" ]
            ]
        ]
