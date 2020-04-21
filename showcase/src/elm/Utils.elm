module Utils exposing
    ( ComponentCategory(..)
    , documentationHeading
    , documentationSubheading
    , documentationText
    , documentationUnorderedList
    , styleSheet
    )

import Ant.Palette as Palette exposing (primaryColor)
import Ant.Typography exposing (fontList, headingColorRgba)
import Css exposing (..)
import Css.Global exposing (global, selector)
import Css.Transitions exposing (transition)
import Html as Unstyled exposing (Attribute, Html)
import Html.Attributes exposing (style)
import Html.Styled as Styled exposing (toUnstyled, fromUnstyled)
import Html.Styled.Attributes exposing (class, css, href)


type ComponentCategory
    = General
    | Layout
    | Navigation
    | DataEntry
    | DataDisplay
    | Feedback
    | Other



-- TODO: deprecate
styleSheet : List ( String, String ) -> List (Attribute msg)
styleSheet =
    List.map (\( styleRule, value ) -> style styleRule value)


commonStyles : List Style
commonStyles =
    [ color (rgba headingColorRgba.r headingColorRgba.g headingColorRgba.b headingColorRgba.a)
    , selection
        [ backgroundColor primaryColor
        , color (hex "#fff")
        ]
    ]


commonTextStyles : List Style
commonTextStyles =
    commonStyles
        ++ [ fontFamilies fontList
           , fontSize (px 14)
           ]


commonHeadingStyles : List Style
commonHeadingStyles =
    commonStyles
        ++ [ fontFamilies ("Avenir" :: fontList)
           , fontWeight (int 500)
           ]


documentationHeading : String -> Html msg
documentationHeading value =
    let
        styles =
            commonHeadingStyles
                ++ [ fontSize (px 30)
                   , marginTop (px 8)
                   , marginBottom (px 20)
                   , lineHeight (px 38)
                   ]
    in
    toUnstyled
        (Styled.h1
            [ css styles
            ]
            [ Styled.text value ]
        )


documentationSubheading : String -> Bool -> Html msg
documentationSubheading value withAnchorLink =
    let
        subheadingLink =
            String.replace " " "-" value

        styledAnchorLink =
            Styled.a
                [ href ("#" ++ subheadingLink)
                , css
                    [ textDecoration none
                    , color Palette.primaryColor
                    , marginLeft (px 8)
                    , hover
                        [ color Palette.primaryColorFaded
                        ]
                    ]
                ]
                [ Styled.text "#" ]

        docSubheadingClass =
            "doc-subheading"

        animationTransitionDuration =
            transition [ Css.Transitions.opacity 250 ]

        hoverAnimationCss =
            [ selector ("." ++ docSubheadingClass ++ " > a")
                [ opacity (num 0)
                , animationTransitionDuration
                ]
            , selector ("." ++ docSubheadingClass ++ ":hover > a")
                [ opacity (num 1)
                , animationTransitionDuration
                ]
            ]

        optionalAnchorLink =
            if withAnchorLink then
                [ styledAnchorLink, global hoverAnimationCss ]

            else
                []

        styles =
            css
                (commonHeadingStyles
                    ++ [ fontSize (px 24)
                       , marginTop (px 38.4)
                       , marginBottom (px 10.8)
                       , lineHeight (px 32)
                       ]
                )
    in
    Unstyled.div []
        [ toUnstyled (Styled.h2 [ styles, class docSubheadingClass ] ([ Styled.span [] [ Styled.text value ] ] ++ optionalAnchorLink))
        ]


documentationText : Html msg -> Html msg
documentationText content =
    let
        styles =
            commonTextStyles
                ++ [ margin2 (px 14) (px 0)
                   , lineHeight (px 28)
                   ]
    in
    toUnstyled
        (Styled.p
            [ css styles
            ]
            [ fromUnstyled content ]
        )


documentationUnorderedList : List String -> Html msg
documentationUnorderedList =
    let
        styles =
            css
                (commonTextStyles
                    ++ [ listStyle circle
                       , listStylePosition inside
                       ]
                )
    in
    toUnstyled
        << Styled.ul [ styles ]
        << List.map (\textItem -> Styled.li [ css [ lineHeight (px 28) ]] [ Styled.text textItem ])