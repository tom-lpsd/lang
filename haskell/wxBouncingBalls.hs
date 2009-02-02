module Main where
import Graphics.UI.WX

-- constants: radius of the ball, and the maximal x and y coordinates
radius, maxX, maxY :: Int
maxY = 300
maxX = 300
radius = 10

-- the max. height is at most max. y minus the radius of a ball.
maxH :: Int
maxH = maxY - radius

--the main function
main = start ballsFrame

ballsFrame
  = do -- a list of balls, where each ball is represented
       -- by a list of all future positions.
       vballs <- varCreate []

       -- create a non-user-resizable top-level (orphan) frame.
       f <- frameFixed [text := "Bouncing balls"]

       -- create a panel to draw in.
       p <- panel f [on paint := paintBalls vballs]

       -- create a timer that updates the ball positions
       t <- timer f [interval := 20, on command := nextBalls vballs p]

       -- react on user input
       set p [on click         := dropBall vballs p              -- drop ball
             ,on clickRight    := (\pt -> ballsFrame)            -- new window
             ,on (charKey 'p') := set t [enabled   :~ not]        -- pause
             ,on (charKey '-') := set t [interval :~ \i -> i*2]  -- increase interval
             ,on (charKey '+') := set t [interval :~ \i -> max 1 (i `div` 2)]
             ]

       -- put the panel in the frame, with a minimal size
       set f [layout := minsize (sz maxX maxY) $ widget p]
   where
     -- paint the balls
     paintBalls :: Var [[Point]] -> DC a -> Rect -> IO ()
     paintBalls vballs dc viewArea
         = do balls <- varGet vballs
              set dc [brushColor := red, brushKind := BrushSolid]
              mapM_ (drawBall dc) [p | (p:ps) <- balls]
     drawBall dc pt
         = circle dc pt radius []
     -- advance all the balls to their next position
     nextBalls :: Var [[Point]] -> Panel () -> IO ()
     nextBalls vballs p
         = do varUpdate vballs (filter (not.null) . map (drop 1))
              repaint p
     -- drop a new ball, gets mouse position as last argument
     dropBall :: Var [[Point]] -> Panel () -> Point -> IO ()
     dropBall vballs p pt
         = do varUpdate vballs (bouncing pt:)
              repaint p
     -- calculate all future positions
     bouncing (Point x y)
         = map (\h -> Point x (maxH-h)) (bounce (maxH-y) 0)
     -- calculate all future heights
     bounce h v
         | h <= 0 && v == 0 = replicate 20 0 -- keep still for 20 frames
         | h <= 0 && v  < 0 = bounce 0 ((-v)-2)
         | otherwise        = h : bounce (h+v) (v-1)
