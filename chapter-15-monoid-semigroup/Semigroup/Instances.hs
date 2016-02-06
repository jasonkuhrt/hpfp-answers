module Instances where


import Control.Monad
import Data.Semigroup
import Test.QuickCheck


main :: IO ()
main = do
  quickCheck (isSemigroupAssoc :: Trivial -> Trivial -> Trivial -> Bool)
  quickCheck (isSemigroupAssoc :: Identity String -> Identity String -> Identity String -> Bool)
  quickCheck (isSemigroupAssoc :: Two String String -> Two String String -> Two String String -> Bool)
  quickCheck (isSemigroupAssoc :: Three String String String -> Three String String String -> Three String String String -> Bool)
  quickCheck (isSemigroupAssoc :: Four String String String String -> Four String String String String -> Four String String String String -> Bool)
  quickCheck (isSemigroupAssoc :: BoolConj -> BoolConj -> BoolConj -> Bool)
  quickCheck (isSemigroupAssoc :: BoolDisj -> BoolDisj -> BoolDisj -> Bool)
  quickCheck (isSemigroupAssoc :: Or String String -> Or String String -> Or String String -> Bool)



isSemigroupAssoc :: (Eq a, Semigroup a) => a -> a -> a -> Bool
isSemigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)



-- 1

data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
  x <> _ =  x

instance Arbitrary Trivial where
  arbitrary = pure Trivial



-- 2

newtype Identity a = Identity a deriving (Eq, Show)

instance Semigroup (Identity a) where
  x <> _ = x

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = liftM Identity arbitrary



-- 3

data Two a b = Two a b deriving (Eq, Show)

instance Semigroup (Two a b) where
  (Two x _) <> (Two _ z) = Two x z

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    x <- arbitrary
    z <- arbitrary
    return (Two x z)



-- 4

data Three a b c = Three a b c deriving (Eq, Show)

instance Semigroup (Three a b c) where
  x <> _ = x

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)



-- 5

data Four a b c d = Four a b c d deriving (Eq, Show)

instance Semigroup (Four a b c d) where
  x <> _ = x

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    return (Four a b c d)



-- 6

newtype BoolConj = BoolConj Bool deriving (Eq, Show)

instance Semigroup BoolConj where
  (BoolConj True) <> (BoolConj True) = BoolConj True
  _ <> _ = BoolConj False

instance Arbitrary BoolConj where
  arbitrary = elements [BoolConj True, BoolConj False]



-- 7

newtype BoolDisj = BoolDisj Bool deriving (Eq, Show)

instance Semigroup BoolDisj where
  (BoolDisj True) <> _ = BoolDisj True
  _ <> (BoolDisj True) = BoolDisj True
  _ <> _ = BoolDisj False

instance Arbitrary BoolDisj where
  arbitrary = elements [BoolDisj True, BoolDisj False]



-- 8

data Or a b = Fst a | Snd b
  deriving (Eq, Show)

instance Semigroup (Or a b) where
  x@(Snd _) <> _ = x
  _ <> x@(Snd _) = x
  _ <> x = x

instance (Arbitrary a, Arbitrary b) => Arbitrary (Or a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [Fst a, Snd b]



-- 9