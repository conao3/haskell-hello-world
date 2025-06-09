mul (i,x) = x * i

calc :: [Int] -> Int
calc xs = foldl (+) 0 . zip [0..]
