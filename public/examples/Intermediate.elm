
import Website.Skeleton
import Website.Tiles

addFolder folder = map (\(x,y) -> (x, y, folder))

intermediate = addFolder "Intermediate/"
  [ ("Slide Show", "SlideShow")
  , ("Turtle", "Turtle")
  , ("Adventure", "Walk")
  , ("Flickr API", "Flickr")
  , ("Light Box", "LightBox")
  , ("Pong", "Pong")
  , ("Analog Clock", "Clock")
  , ("Diagrams", "Physics")
  , ("Keyboard & Animations", "MovingBox")
  , ("Quick Animations", "Slide")
  , ("Stamps", "Stamps")
  , ("Graphs", "Plot")
  , ("Form Validation", "Form")
  , ("Pascal's Triangle", "PascalsTriangle")
  , ("Fibonacci Tiles", "FibonacciTiles")
  , ("Web", "Web")
  ]

intro =  [markdown|

### Intermediate Examples

These examples bring together computation, graphics, and reactions to
build larger components.

<br/>

|]

content w =
  let tiles = tile w $ map toTile intermediate in
  width w intro `above` container w (heightOf tiles) midTop tiles

main = lift (skeleton content) Window.width
