# haskell-hello-world

A hands-on introduction to Haskell fundamentals using GHCi (the Glasgow Haskell Compiler interactive environment).

## Getting Started

This project uses Nix flakes for reproducible development environments.

```sh
nix develop
ghci
```

```
GHCi, version 9.8.4: https://www.haskell.org/ghc/  :? for help
ghci> putStrLn "Hello, World"
Hello, World

ghci> :quit
Leaving GHCi.
```

## Examples

### Working with Lists

Calculate the weighted sum: `10 * 0 + 20 * 1 + 30 * 2 + 40 * 3 + 50 * 4`

```haskell
ghci> [10,20,30,40,50]
[10,20,30,40,50]

ghci> [0..4]
[0,1,2,3,4]

ghci> ['a'..'h']
"abcdefgh"

ghci> zip [0..] [10,20,30,40,50]
[(0,10),(1,20),(2,30),(3,40),(4,50)]

ghci> let mul (i,x) = x * i

ghci> let ret1 = zip [0..] [10,20,30,40,50]

ghci> map mul ret1
[0,20,60,120,200]

ghci> let ret2 = map mul ret1
```

### Currying and Partial Application

In Haskell, functions are curried by default. While you cannot display a partially applied function directly in GHCi, you can bind it to a variable and use it later:

```haskell
ghci> map mul
<interactive>:12:1: error: [GHC-39999]
    • No instance for 'Show ([(Integer, Integer)] -> [Integer])'
        arising from a use of 'print'
        (maybe you haven't applied a function to enough arguments?)
    • In a stmt of an interactive GHCi command: print it

ghci> let mul_map = map mul

ghci> mul_map ret1
[0,20,60,120,200]
```

### Folding (Reduce)

Compute the sum: `((((0 + 0) + 20) + 60) + 120) + 200`

The `(+)` syntax wraps the infix operator for prefix usage:

```haskell
ghci> :t (+)
(+) :: Num a => a -> a -> a

ghci> (+) 1 2
3

ghci> 1 + 2
3
```

Using `foldl` to reduce a list:

```haskell
ghci> :t foldl
foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b

ghci> foldl (+) 0 ret2
400
```

Understanding the type signature `foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b`:
- `Foldable t =>` - constraint that `t` must be a Foldable type
- `(b -> a -> b)` - first argument: the combining function
- `b` - second argument: the initial accumulator value
- `t a` - third argument: the foldable structure
- `b` - return type: the final accumulated result

### Loading Haskell Files

Run `calc.hs` which implements the weighted sum calculation:

```sh
ghci calc.hs
```

```
GHCi, version 9.8.4: https://www.haskell.org/ghc/  :? for help
[1 of 2] Compiling Main             ( calc.hs, interpreted )
Ok, one module loaded.
ghci> calc [10,20,30,40,50]
400
```

### Function Composition

The `.` operator composes functions together:

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

### Character and String Functions

The `char.hs` file defines a simple digit checker:

```haskell
isDigit :: Char -> Bool
isDigit c = c >= '0' && c <= '9'
```

```sh
ghci char.hs
```

```
ghci> isDigit '0'
True
ghci> isDigit 'a'
False
```

The `string.hs` file demonstrates recursion with string building:

```haskell
makeString :: Char -> Int -> [Char]
makeString c 0 = []
makeString c n = c : makeString c (n - 1)
```

```sh
ghci string.hs
```

```
ghci> makeString 'w' 5
"wwwww"
```

### Longest Repeated Substring

Find the longest repeated substring in text. For example:

```
Ask not what your country can do for you,
but what you can do for your country.
```

The longest repeated substring is " can do for you".

```sh
ghci -XNoMonomorphismRestriction maxDupStr.hs
```

```
ghci> maxDupStr "Ask not what your country can do for you, but what you can do for your country."
" can do for you"
```

## Development Tools

The Nix flake provides:
- GHC (Glasgow Haskell Compiler)
- Cabal (build tool)
- HLS (Haskell Language Server)
- Ormolu (code formatter)
- HLint (linter)

## License

See repository for license information.
