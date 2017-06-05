module Main where
import Shapes
import PrettyPics





main :: IO ()
main = do let pic = makePicture $ RandomWalk([((0,0), 0.5), ((200,0), 0.5), ((0,200), 0.5)],10000)
          let pic2 = makePicture $ RandomWalk([((0,0), 0.2), ((200,0), 0.4), ((200,200), 0.2), ((0,200), 0.4)],100000)
          let Picture(x,y,picdata) = makePicture $ Circle((100,200),100,10)
          let pic3 = Picture(100,100,picdata)
          let pic4 = Picture(5000,1000,picdata)
          savePicture "fcuk3.pbm" pic3
          savePicture "fcuk4.pbm" pic4
          --savePicture "tr2.pbm" pic
          --savePicture "sq.pbm" pic2
