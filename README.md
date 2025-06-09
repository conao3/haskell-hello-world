# haskell-hello-world

## Section1

### hello-world

```sh
$ nix develop
$ ghci
GHCi, version 9.8.4: https://www.haskell.org/ghc/  :? for help
ghci> putStrLn "Hello, World"
Hello, World

ghci> :quit
Leaving GHCi.
```

## Section2

### Sample1

```python
10 * 0 + 20 * 1 + 30 * 2 + 40 * 3 + 50 * 4
```

```haskell
ghci> [10,20,30,40,50]
[10,20,30,40,50]

ghci> [0..4]
[0,1,2,3,4]

ghci> ['a'..'h']
"abcdefgh"

ghci> zip [0..] [10,20,30,40,50]
[(0,10),(1,20),(2,30),(3,40),(4,50)]

ghci> let ret1 = zip [0..] [10,20,30,40,50]

ghci> let mul (i,x) = x * i

ghci> map mul ret1
[0,20,60,120,200]

ghci> let ret2 = map mul ret1
```

- カリー化
  - ただ、REPL上ではdisplayできなくてエラーになった。
  - 変数に入れることで第1引数のみ部分適用した関数を束縛して利用できる。
```haskell
ghci> map mul
<interactive>:12:1: error: [GHC-39999]
    • No instance for ‘Show ([(Integer, Integer)] -> [Integer])’
        arising from a use of ‘print’
        (maybe you haven't applied a function to enough arguments?)
    • In a stmt of an interactive GHCi command: print it

ghci> let mul_map = map mul

ghci> mul_map ret1
[0,20,60,120,200]
```

### Sample2
reduce

```python
((((0 + 0) + 20) + 60) + 120) + 200
```

- `(+)` は `+` が中置演算子のためにカッコで囲う必要がある
  ```haskell
  ghci> :t (+)
  (+) :: Num a => a -> a -> a

  ghci> (+) 1 2
  3

  ghci> 1 + 2
  3
  ```

```haskell
ghci> :t foldl
foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b

ghci> foldl (+) 0 ret2
400
```

- `foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b` の読み方
  - `foldl ::`: 関数の名前
  - `Foldable t =>`: `t` を `Foldable` とするよ
  - `(b -> a -> b) ->`: 第1引数
  - `b ->`: 第2引数
  - `t a ->`: 第3引数
  - `b`: 結果

- `a` とか `b` とかは具体的な型はないが、第1引数の関数の型変数になっている。

### Sample3
`calc.hs` に保存したものを実行してみる
```sh
$ ghci calc.hs
GHCi, version 9.8.4: https://www.haskell.org/ghc/  :? for help
[1 of 2] Compiling Main             ( calc.hs, interpreted )
Ok, one module loaded.
ghci> calc [10,20,30,40,50]
400
```

### Sample4
関数合成の演算子 `.`

```haskell
ghci> let mul (i,x) = x * i
ghci> let ret1 = zip [0..] [10,20,30,40,50]
ghci> let ret2 = map mul ret1
ghci> foldl (+) 0 ret2
400

ghci> foldl (+) 0 (map mul (zip [0..] [10,20,30,40,50]))
400

ghci> :t calc
calc :: (Num a, Enum a) => [a] -> a
ghci> calc [10,20,30,40,50]
400
```

### Sample5
`char.hs` として以下を保存する
```haskell
isDigit :: Char -> Bool
isDigit c = c >= '0' && c <= '9'
```

```
$ ghci char.hs
GHCi, version 9.8.4: https://www.haskell.org/ghc/  :? for help
[1 of 2] Compiling Main             ( char.hs, interpreted )
Ok, one module loaded.
ghci> isDigit '0'
True
ghci> isDigit 'a'
False
```

`string.hs` として以下を保存する
```haskell
makeString :: Char -> Int -> [Char]
makeString c 0 = []
makeString c n = c : makeString c (n - 1)
```

```
$ ghci string.hs
GHCi, version 9.8.4: https://www.haskell.org/ghc/  :? for help
[1 of 2] Compiling Main             ( string.hs, interpreted )
Ok, one module loaded.
ghci> makeString 'w' 5
"wwwww"
```

## Section3
### 最長重複文字列問題

```
Ask not what your country can do for you,
but what you can do for your country.
```

-> 最長重複文字列は「can do for you」

```
$ ghci -XNoMonomorphismRestriction maxDupStr.hs
GHCi, version 9.8.4: https://www.haskell.org/ghc/  :? for help
[1 of 2] Compiling Main             ( maxDupStr.hs, interpreted )

maxDupStr.hs:9:23: warning: [GHC-63394] [-Wx-partial]
    In the use of ‘tail’
    (imported from Data.List, but defined in GHC.List):
    "This is a partial function, it throws an error on empty lists. Replace it with drop 1, or use pattern matching or Data.List.uncons instead. Consider refactoring to use Data.List.NonEmpty."
  |
9 | makePair xs = zip xs (tail xs)
  |                       ^^^^
Ok, one module loaded.
ghci> maxDupStr "Ask not what your country can do for you,

<interactive>:1:53: error: [GHC-21231]
    lexical error in string/character literal at end of input
ghci> maxDupStr "Ask not what your country can do for you, but what you can do for your country."
" can do for you"
```
