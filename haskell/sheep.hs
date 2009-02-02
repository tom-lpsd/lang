import Control.Monad
import Maybe

-- everything you need to know about sheep
data Sheep = Sheep {name::String, mother::Maybe Sheep, father::Maybe Sheep}

-- we show sheep by name
instance Show Sheep where
  show s = show (name s)

-- now we can use `comb` to build complicated sequences
maternalGrandfather :: Sheep -> Maybe Sheep
maternalGrandfather s = (return s) >>= mother >>= father

fathersMaternalGrandmother :: Sheep -> Maybe Sheep
fathersMaternalGrandmother s = (return s) >>= father >>= mother >>= mother 

mothersPaternalGrandfather :: Sheep -> Maybe Sheep
mothersPaternalGrandfather s = (return s) >>= mother >>= father >>= father 

-- this builds our sheep family tree
breedSheep :: Sheep
breedSheep = let adam   = Sheep "Adam" Nothing Nothing
                 eve    = Sheep "Eve" Nothing Nothing
		 uranus = Sheep "Uranus" Nothing Nothing
		 gaea   = Sheep "Gaea" Nothing Nothing
		 kronos = Sheep "Kronos" (Just gaea) (Just uranus)
                 holly  = Sheep "Holly" (Just eve) (Just adam)
	         roger  = Sheep "Roger" (Just eve) (Just kronos)
	         molly  = Sheep "Molly" (Just holly) (Just roger)
	     in Sheep "Dolly" (Just molly) Nothing

-- ex2.
-- parent s = (mother s) `mplus` (father s)
-- grandparent s = (mother s >>= parent) `mplus` (father s >>= parent)

-- ex3.
-- parent s = (maybeToList $ mother s) `mplus` (maybeToList $ father s)
-- grandparent s = (return s) >>= parent >>= parent

parent :: (MonadPlus m) => Sheep -> m Sheep
grandparent :: (MonadPlus m) => Sheep -> m Sheep
parent s = (father s) >>= return
grandparent s = (father s) >>= return

-- print Dolly's maternal grandfather
main :: IO ()
main = let dolly = breedSheep
       in do { print (maternalGrandfather dolly); print $ grandparent dolly }
