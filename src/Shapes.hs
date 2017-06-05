module Shapes(movePicture, addPictures, makePicture, Point, Shape(..)) where
import PrettyPics
import qualified Data.Set as Set





type Point = (Float,Float)

data PathOrder = Forward Float | Turn Float

data Shape = Circle (Point,Float,Float) -- Center, Radius, Thickness
           | Line (Point,Point,Float) -- Start, End, thickness
           | Polygon ([Point],Float) -- List of vertices, thickness
           | Path([PathOrder],Float) -- list of orders, thickness
           | RandomWalk ([(Point,Float)],Int) -- List of (vertex, weight), iterations
           | Chessboard

-- makePicture :: Shape -> Picture
makePicture :: Shape -> Picture
makePicture (Circle((ox,oy),r,t)) = Picture( round  $ (2*r+ox), round $ 2*r+oy, pixels)
  where pixels x y = if circlePoint x y
                     then Black
                     else White
        circlePoint x y = abs(sqrt((ox-x)*(ox-x)+(oy-y)*(oy-y)) - r) < t / 2

makePicture Chessboard = Picture(1000,1000, \x y -> if (floor x + floor y) `mod` 2 == 0 then Black else White)

makePicture (RandomWalk(pts, iter)) = RandomPicture(ceiling maxX, ceiling maxY, \r -> pixels (pset r))
  where maxX = foldl max 0 $ map (fst.fst) pts
        maxY = foldl max 0 $ map (snd.fst) pts
        pset rands=  makeSet Set.empty (fst $ head pts) (take iter rands)
        pixels s x y = if pathPoint s x y
                           then Black
                           else White
        makeSet set cur (r:rs) = makeSet (Set.insert (floor2 cur) set) (moveTo cur (rpoint r)) rs
        makeSet set _ _ = set
        moveTo (x,y) ((x2,y2),w) = (x * (1-w) + x2 * w, y * (1-w) + y2 * w)
        rpoint r = head $ drop (floor (r * fromIntegral (length pts))) pts
        floor2 (x,y) = (floor x, floor y)
        pathPoint s x y = Set.member (floor2(x,y)) s
makePicture _ = undefined



movePicture :: Float -> Float -> Picture -> Picture
movePicture mx my (RandomPicture(w,h,picData)) = RandomPicture(round mx + w, round my + h, pic)
  where pic rands x y = picData rands (x - mx) (y - my)
movePicture mx my (Picture(w,h,picData)) = Picture(round mx + w, round mx + h, pic)
  where pic x y = picData (x - mx) (y - my)



colorOr :: Color -> Color -> Color
colorOr Black _ = Black
colorOr _ Black = Black
colorOr _ _ = White

addPictures :: Picture -> Picture -> Picture
addPictures (Picture(w,h,picData)) p2 = aux p2
  where aux (Picture(w2,h2,picData2)) = Picture(max w w2, max h h2, pOrP picData picData2)
        aux (RandomPicture(w2,h2,picData2)) = RandomPicture((max w w2, max h h2, pOrR picData picData2))
        pOrP d1 d2 x y = (d1 x y) `colorOr` (d2 x y)
        pOrR d1 d2 rands x y = (d1 x y) `colorOr` (d2 rands x y)

addPictures p1@(RandomPicture(_,_,_)) p2@(Picture(_,_,_))  = addPictures p2 p1
addPictures (RandomPicture(w,h,picData)) (RandomPicture(w2,h2,picData2))
  = RandomPicture(max w w2, max h h2, rOrR picData picData2)
  where rOrR d1 d2 rands x y = (d1 rands x y) `colorOr` (d2 rands x y)
