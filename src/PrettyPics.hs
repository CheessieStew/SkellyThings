module PrettyPics(savePicture, Picture(..), Color(..), PictureData()) where
import System.IO
import System.Random

type PictureData = (Float -> Float -> Color)
data Picture = Picture(Int, Int, PictureData) | RandomPicture(Int, Int, [Float]->PictureData)
data Color = Black | White


savePicture :: String -> Picture -> IO ()
savePicture path (RandomPicture(w,h,picGen)) =  do
    gen <- getStdGen
    savePicture path (Picture(w,h,(picGen (randoms gen))))

savePicture path (Picture(hor,ver,colors)) = do
    handle <- openFile path WriteMode
    hPutStrLn handle "P1"
    hPutStr handle $ show hor
    hPutStr handle " "
    hPutStrLn handle $ show ver
    _ <- sequence $ hWritePic handle
    hClose handle
  where
     hWritePic h = do
         y <- [0..ver-1]
         x <- [0..hor-1]
         if x == hor-1
           then [hPutStrLn h $ toStr $ colors (fromIntegral x) (fromIntegral y)]
           else [hPutStr h $ (toStr $ colors (fromIntegral x) (fromIntegral y)) ++ " "]
     toStr Black = "1 "
     toStr White = "0 "
