import Pictures

inversion :: Picture -> Picture
inversion = map (map invert)

blackHorse :: Picture
blackHorse = inversion horse

rotateHorse :: Picture
rotateHorse = rotate horse

black :: Picture
black = superimpose horse blackHorse

dup f = (\x -> f x x)
twice f = f . f

makeTile :: Picture -> Picture -> Picture
makeTile x y = above (sideBySide x y) (sideBySide y x)

blackWhite :: Picture
blackWhite = makeTile black white

chessBoard :: Picture
chessBoard = twice (dup above) . twice (dup sideBySide) $ blackWhite

makePic f x y = above (sideBySide x y) (sideBySide (f y) (f x))

pic1 = makePic id horse blackHorse
pic2 = makePic flipV horse blackHorse
pic3 = makePic rotate horse blackHorse
pic4 = makePic flipH horse blackHorse
