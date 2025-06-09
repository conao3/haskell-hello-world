mul (i,x) = x * i

calc :: [Int] -> Int
calc xs = foldl (+) 0 (map mul (zip [0..] xs))
