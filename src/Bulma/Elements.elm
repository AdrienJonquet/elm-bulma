
module Bulma.Elements exposing (..)

-- DOCS ------------------------------------------------------------------------

{-| TODO 

# Table of Contents
Coming soon!

# Box
@docs Box
@docs box

# Button
@docs Button, ButtonModifiers, buttonModifiers
@docs button, staticButton, easyButton
@docs iconButton, staticIconButton, easyIconButton

## Button GROUPS
@docs ButtonGroup
@docs buttonGroup, connectedButtonGroup

# Content
@docs Content
@docs content

# Delete
@docs Delete
@docs delete, easyDelete

# Form
Coming soon!

# Image
@docs Image, ImageModifiers, ImageSize, ImageAspectRatio, imageModifiers
@docs image, easyImage

# Notification
Coming soon!

# Progress
Coming soon!

# Table
Coming soon!

# Tag
Coming soon!

# Title
Coming soon!

-}

-- IMPORTS ---------------------------------------------------------------------

import Helpers exposing (..)

import BulmaClasses exposing (..)

import Bulma.Modifiers as Modifiers exposing (..)

import Bulma.Elements.Icon as Icon exposing ( Icon )

import Html exposing ( Html, text, div, a, img )
import Html.Events exposing ( onClick )
import Html.Attributes as Attr exposing ( class )

import List exposing ( filter )


-- BOX -------------------------------------------------------------------------

{-| TODO
-}
type alias Box msg = Html msg

{-| TODO
-}
box : Attrs msg -> Htmls msg -> Box msg
box = node "div" [] [ bulma.box.container ]


-- BUTTON ----------------------------------------------------------------------

{-| TODO
-}
type alias Button msg = Html msg

{-| TODO
-}
button : ButtonModifiers -> Attrs msg -> Htmls msg -> Button msg
button {disabled,outlined,inverted,size,state,color}
  = node "a" ( if disabled then [ Attr.disabled True ] else [] )
    [ bulma.button.ui
    , case outlined of
        True  -> bulma.button.style.isOutlined
        False -> ""
    , case inverted of
        True  -> bulma.button.style.isInverted
        False -> ""
    -- TODO: size
    -- TODO: state
    -- TODO: color
    ]
  
{-| TODO
-}
staticButton : ButtonModifiers -> Attrs msg -> Htmls msg -> Button msg
staticButton mods = button mods << (::) (class bulma.button.style.isStatic)

{-| TODO
-}
easyButton : ButtonModifiers -> Attrs msg -> msg -> String -> Button msg
easyButton mods attrs msg str
  = button mods
    (onClick msg :: attrs)
    [ text str ]

-- WITH ICON --

{-| TODO
-}
iconButton : ButtonModifiers -> Icon msg -> Attrs msg -> Htmls msg -> Button msg
iconButton mods icon attrs htmls
  = button mods attrs <| icon :: htmls
    
{-| TODO
-}
staticIconButton : ButtonModifiers -> Icon msg -> Attrs msg -> Htmls msg -> Button msg
staticIconButton mods icon = iconButton mods icon << (::) (class bulma.button.style.isStatic)

{-| TODO
-}
easyIconButton : ButtonModifiers -> Icon msg -> Attrs msg -> msg -> String -> Button msg
easyIconButton mods icon attrs msg str
  = button mods (onClick msg :: attrs)
    [ icon 
    , text str
    ]

-- GROUP --

{-| TODO
-}
type alias ButtonGroup msg = Html msg

{-| TODO
-}
buttonGroup : HorizontalAlignment -> Attrs msg -> List (Button msg) -> ButtonGroup msg
buttonGroup alignment
  = node "div" []
    [ bulma.field.container
    , case alignment of
        Left     -> ""
        Centered -> bulma.field.isGrouped.centered
        Right    -> bulma.field.isGrouped.right
    ]

{-| TODO
-}
connectedButtonGroup : HorizontalAlignment -> Attrs msg -> List (Button msg) -> ButtonGroup msg
connectedButtonGroup alignment
  = node "div" [] [ bulma.field.container
                  , case alignment of
                      Left     -> bulma.field.hasAddons.left
                      Centered -> bulma.field.hasAddons.centered
                      Right    -> bulma.field.hasAddons.right
                  ]

-- MODIFIERS --

{-| TODO
-}
type alias ButtonModifiers = { disabled : Bool
                             , outlined : Bool
                             , inverted : Bool
                             , size     : Size
                             , state    : State
                             , color    : Color
                             }

{-| TODO
-}
buttonModifiers : ButtonModifiers
buttonModifiers = { disabled = False
                  , outlined = False
                  , inverted = False
                  , size     = Normal
                  , state    = Blur
                  , color    = Default
                  }


-- CONTENT ---------------------------------------------------------------------

{-| TODO
-}
type alias Content msg = Html msg

{-| TODO
-}
content : Size -> Attrs msg -> Htmls msg -> Content msg
content size
  = node "div" []
    [ bulma.content.container
    , case size of
        Small  -> bulma.content.size.isSmall
        Normal -> ""
        Medium -> bulma.content.size.isMedium
        Large  -> bulma.content.size.isLarge
    ]


-- DELETE ----------------------------------------------------------------------

{-| TODO
-}
type alias Delete msg = Html msg

{-| TODO
-}
delete : Attrs msg -> Htmls msg -> Delete msg
delete = node "a" [] [ bulma.delete.ui ]

{-| TODO
-}
easyDelete : Attrs msg -> msg -> Delete msg
easyDelete attrs msg = delete (onClick msg :: attrs) []


-- IMAGE -----------------------------------------------------------------------

{-| TODO
-}
type alias Image msg = Html msg

{-| TODO
-}
type alias ImageModifiers = { size        : Maybe ImageSize
                            , aspectRatio : Maybe ImageAspectRatio
                            }

{-| TODO
-}
type ImageSize = X16
               | X24
               | X32
               | X48
               | X64
               | X96
               | X128

{-| TODO
-}
type ImageAspectRatio = OneByOne
                      | FourByThree
                      | ThreeByTwo
                      | SixteenByNine
                      | TwoByOne

{-| TODO
-}
imageModifiers : ImageModifiers
imageModifiers = { size        = Nothing
                 , aspectRatio = Nothing
                 }

{-| TODO
-}
image : ImageModifiers -> Attrs msg -> Htmls msg -> Image msg
image {size,aspectRatio}
  = node "figure" []
    [ case size of
        Just X16  -> bulma.image.size.is16x16
        Just X24  -> bulma.image.size.is24x24
        Just X32  -> bulma.image.size.is32x32
        Just X48  -> bulma.image.size.is48x48
        Just X64  -> bulma.image.size.is64x64
        Just X96  -> bulma.image.size.is96x96
        Just X128 -> bulma.image.size.is128x128
        _         -> ""
    , case aspectRatio of
        Just OneByOne      -> bulma.image.size.is1by1
        Just FourByThree   -> bulma.image.size.is4by3
        Just ThreeByTwo    -> bulma.image.size.is3by2
        Just SixteenByNine -> bulma.image.size.is16by9
        Just TwoByOne      -> bulma.image.size.is2by1
        _                  -> ""
    ]

{-| TODO
-}
easyImage : ImageModifiers -> Attrs msg -> String -> Image msg
easyImage mods attrs src = image mods attrs [ img [ Attr.src src ] [] ]

-- easyLinkedImage : Attrs msg -> msg -> String -> Image msg

