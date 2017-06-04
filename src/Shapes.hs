module Shapes(movePicture, addPictures, makePicture, Point, Shape(..)) where
import PrettyPics





type Point = (Float,Float)

data PathOrder = Forward Float | Turn Float

data Shape = Circle (Point,Float,Float) -- Center, Radius, Thickness
           | Line (Point,Point,Float) -- Start, End, thickness
           | Polygon ([Point],Float) -- List of vertices, thickness
           | Path([PathOrder],Float) -- list of orders, thickness
           | RandomWalk ([(Point,Float)],Int) -- List of (vertex, weight), iterations

makePicture :: Shape -> Picture
makePicture _ = undefined

movePicture :: Float -> Float -> Picture -> Picture
movePicture _ _ _ = undefined

addPictures :: Picture -> Picture -> Picture
addPictures _ _ = undefined

scalePicture :: Float -> Picture -> Picture
scalePicture _ _ = undefined

reframePicture :: Float -> Picture -> Picture
reframePicture _ _ = undefined
