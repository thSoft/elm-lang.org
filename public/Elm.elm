import Website.Skeleton
import Website.Tiles
import Website.ColorScheme

intro = [markdown|

### The Elm Programming Language

**Elm is a [functional reactive programming][frp] language meant to replace HTML/CSS/JavaScript.**
Elm is optimized for creating [web][flow] [GUIs][canvas], [supporting complex user input][frp],
and [avoiding callbacks][escape].

  [flow]:    /edit/examples/Elements/FlowDown2.elm "Flow down example"
  [canvas]:  /edit/examples/Reactive/Transforms.elm "Canvas Example"
  [escape]:  /learn/Escape-from-Callback-Hell.elm
  [why-elm]: http://www.testblogpleaseignore.com/2012/06/21/why-elm/ "Why Elm?"
  [frp]:     /learn/What-is-FRP.elm "functional reactive programming"
  [http]:    /edit/examples/JavaScript/ZipCodes.elm "HTTP requests"

|]

features = [markdown|

#### Features

* [Functional Reactive Programming][frp]

* [Strong][strong] / [static][static] types with [type inference][infer]

* [Native Markdown support](/edit/examples/Elements/Markdown.elm)

* [Core Libraries](/Documentation.elm) and [Module System][modules]

  [frp]:    /learn/What-is-FRP.elm "functional reactive programming"
  [strong]: http://en.wikipedia.org/wiki/Strong_typing "strongly"
  [static]: http://en.wikipedia.org/wiki/Type_system#Static_typing "statically"
  [infer]:  http://en.wikipedia.org/wiki/Type_inference "type inference"
  [modules]: http://www.testblogpleaseignore.com/2012/06/19/announcing-elm-0-3-modules/ "Module System"

|]

news = [markdown|

#### News

[Extensible Records in Elm 0.7][v7]

Elm featured on [InfoQ][video] and [O&rsquo;Reilly Radar][radar]

[Escape from Callback Hell][escape]: AJAX without callbacks

[Making Pong in Elm][pong]: a comprehensive walkthrough

  [escape]: /learn/Escape-from-Callback-Hell.elm "Escape from Callback Hell"
  [pong]: /blog/games-in-elm/part-0/Making-Pong.html "Pong"
  [v7]: /blog/announce/version-0.7.elm "Extensible Records"
  [video]: http://www.infoq.com/presentations/Elm "Making the Web Functional"
  [radar]: http://radar.oreilly.com/2012/12/emerging-languages-spotlight-elm.html "Emerging Languages Spotlight"

|]

contact = [markdown|

#### Contact / Contribute

Elm's [mailing list][7] is the place to go for questions, announcements, and discussion.
Or see if anyone is on IRC ([`#elm` on freenode][irc]).

There are also tons of ways to [contribute to Elm](/Contribute.elm).

  [7]: https://groups.google.com/forum/?fromgroups#!forum/elm-discuss "mailing list"
  [irc]: http://webchat.freenode.net/?channels=elm "#elm"

|]

exampleText = [markdown|

#### Examples

Read, use, and edit real Elm programs online. Think about how
you would implement the same things with HTML, CSS, and JavaScript.
Tons more examples can be found [here](/Examples.elm).

|]

infoqDesc = [markdown|

#### Making the Web Functional

[An introduction to Elm][vid]. Why you should care. How it works. How to make cool stuff.
The live examples came out a bit grainy, so follow along [here][exs].

  [vid]: http://www.infoq.com/presentations/Elm "Elm at Emerging Languages Camp"
  [exs]: https://github.com/evancz/elm-at-strangeloop#elm-at-strangeloop "Non-grainy Examples"

|]

downloadText = [markdown|

#### Get Started!

Download Elm and start using it now. Or [Try Elm](/try) online
with no set-up at all.
|]

examples = map (\(x,y) -> (x, y, "Intermediate/"))
  [ ("Analog Clock", "Clock")
  , ("Stamps", "Stamps")
  , ("Diagrams", "Physics")
  , ("Turtle", "Turtle")
  , ("Slide Show", "SlideShow")
  , ("Walking", "Walk")
  ]

content w =
  let tiles = miniTiles w examples
  in  flow down [ width w exampleText
                , container w (heightOf tiles) middle tiles ]

infoq w =
  let lnk = "http://www.infoq.com/presentations/Elm"
      vid = image (min w 320) (min (round (toFloat w * 4/5)) 240) "/infoq.jpg"
  in  width w infoqDesc `above` Graphics.link lnk vid

download w =
  let lnk = "https://github.com/evancz/Elm/blob/master/README.md#elm" in
  flow down [ width w downloadText
            , container w 60 middle $
              layers [ color mediumGrey . container 200 60 middle .
                       color lightGrey  . container 198 58 middle .
                       text . Text.height 1.5 $ toText "Download"
                     , Graphics.link lnk $ spacer 200 60 ]
            ]

info w = if w < 500 then infoSmall w else infoBig w

infoBig w =
  let wid = (w-60) `div` 2
  in  flow down
       [ width w intro
       , spacer 10 10
       , flow right [ content wid, spacer 60 10, infoq wid ]
       , spacer 10 40
       , flow right [ width wid features, spacer 60 10, width wid news ]
       , spacer 10 40
       , flow right [ width wid contact, spacer 60 10, download wid ]
       , spacer 10 40
       ]

infoSmall w =
  let wid = min w 500
  in  flow down . List.intersperse (spacer 10 10) $
       [ width wid intro
       , width wid features
       , width wid news
       , content wid
       , infoq wid
       , width wid contact
       , download wid
       , spacer 10 30
       ]

main = lift (skeleton info) Window.width

title = constant (JavaScript.castStringToJSString "The Elm Programming Language")
foreign export jsevent "elm_title"
  title :: Signal JSString
