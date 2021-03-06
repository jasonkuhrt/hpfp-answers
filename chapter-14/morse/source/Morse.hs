module Morse (
  Morse,
  charCodeMap,
  codeCharMap,
  charToMorse,
  morseToChar,
  stringToMorse
) where

import qualified Data.Map as M



type Morse = String

-- We need a map between Characters and their associated Morse Code to do
-- code lookups by character. We will also want the reverse: a map of codes to
-- characters to do lookups in the opposite direction.

charCodeMap :: M.Map Char Morse
charCodeMap = M.fromList [
      ('a', ".-")
    , ('b', "-...")
    , ('c', "-.-.")
    , ('d', "-..")
    , ('e', ".")
    , ('f', "..-.")
    , ('g', "--.")
    , ('h', "....")
    , ('i', "..")
    , ('j', ".---")
    , ('k', "-.-")
    , ('l', ".-..")
    , ('m', "--")
    , ('n', "-.")
    , ('o', "---")
    , ('p', ".--.")
    , ('q', "--.-")
    , ('r', ".-.")
    , ('s', "...")
    , ('t', "-")
    , ('u', "..-")
    , ('v', "...-")
    , ('w', ".--")
    , ('x', "-..-")
    , ('y', "-.--")
    , ('z', "--..")
    , ('1', ".----")
    , ('2', "..---")
    , ('3', "...--")
    , ('4', "....-")
    , ('5', ".....")
    , ('6', "-....")
    , ('7', "--...")
    , ('8', "---..")
    , ('9', "----.")
    , ('0', "-----")
  ]

codeCharMap :: M.Map Morse Char
codeCharMap = M.foldWithKey (flip M.insert) M.empty charCodeMap

-- We need some functions that expose convenient lookup operations on our
-- local map data.

charToMorse :: Char -> Maybe Morse
charToMorse char = M.lookup char charCodeMap

morseToChar :: Morse -> Maybe Char
morseToChar morse = M.lookup morse codeCharMap

stringToMorse :: String -> Maybe [Morse]
stringToMorse string = sequence $ fmap charToMorse string
