module Homework.Week03.Assignment (
  skips,
  localMaxima,
  histogram
) where

import Data.List (transpose)

-- #1
every :: Int -> [a] -> [a]
every n xs = case drop (n-1) xs of
              (y:ys) -> y : every n ys
              [] -> []

takeIt :: Int -> [ a ] -> Int -> [[ a ]]
takeIt _ _ 0  = []
takeIt n xs todo = (every n xs) : (takeIt (n+1) (xs) (todo-1))

skips :: [a] -> [[a]]
skips xs = takeIt 1 xs (length xs)

-- #2
localMaxima :: [Integer] -> [Integer]
localMaxima (a : (b : [ c ])) = if (b > a && b > c) then [ b ] else [ ]
localMaxima (a : (b : c : (xs))) = if (b > a && b > c) then b : localMaxima (b : c : xs) else localMaxima (b : c : xs)
localMaxima _  = [ ]

-- #3
histogram :: [Integer] -> String
histogram xs = let
  freqs = map (\n -> foldr (\x acc -> if n == x then succ acc else acc) 0 xs) [0..9]
  height = maximum freqs
  cols = map (\n -> replicate (height - n) ' ' ++ replicate n '*') freqs
  in concatMap (++ "\n")  (transpose cols) ++ "==========\n0123456789\n"
