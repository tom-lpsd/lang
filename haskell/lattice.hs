lattice :: Int -> Int -> [[Int]]
lattice 1 n = [[n]]
lattice d n = [ x:y | x <- [0..n], y <- lattice (d-1) (n-x) ]
all_lattices d = concat [ lattice d i | i <- [0..] ]
