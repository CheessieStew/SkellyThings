module Main where
import Shapes
import PrettyPics





main :: IO ()
main = do let pic = makePicture $ RandomWalk([((0,0), 0.5), ((200,0), 0.5), ((0,200), 0.5)],10000)
          let pic2 = makePicture $ RandomWalk([((0,0), 0.2), ((200,0), 0.4), ((200,200), 0.2), ((0,200), 0.4)],100000)
          savePicture "tr2.pbm" pic
          savePicture "sq.pbm" pic2
