module Main exposing (Model, Msg, main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


type Msg
    = Nop


type alias Model =
    { version : Int
    }


main =
    Browser.sandbox { init = init, update = update, view = view }


init : Model
init =
    { version = 0 }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Nop ->
            { model | version = model.version + 1 }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Nop ] [ text "-" ]
        , div [] [ text (String.fromInt model.version) ]
        ]

