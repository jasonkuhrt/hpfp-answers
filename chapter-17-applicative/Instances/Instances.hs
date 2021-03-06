module Instances where

import Test.QuickCheck
import Test.QuickCheck.Classes
import Test.QuickCheck.Checkers



type S = String

test :: IO ()
test = do
  quickBatch $ functor $ Identity ("","","")
  quickBatch $ applicative $ Identity ("","","")

  quickBatch $ functor $ (undefined :: Pair (S,S,S))
  quickBatch $ applicative $ (undefined :: Pair (S,S,S))

  quickBatch $ monoid $ (undefined :: Two S (S,S,S))
  quickBatch $ functor $ (undefined :: Two S (S,S,S))
  quickBatch $ applicative $ (undefined :: Two S (S,S,S))

  quickBatch $ monoid $ (undefined :: Three S S (S,S,S))
  quickBatch $ functor $ (undefined :: Three S S (S,S,S))
  quickBatch $ applicative $ (undefined :: Three S S (S,S,S))

  quickBatch $ monoid $ (undefined :: Three2 S (S,S,S))
  quickBatch $ functor $ (undefined :: Three2 S (S,S,S))
  quickBatch $ applicative $ (undefined :: Three2 S (S,S,S))

  quickBatch $ monoid $ (undefined :: Four S S S (S,S,S))
  quickBatch $ functor $ (undefined :: Four S S S (S,S,S))
  quickBatch $ applicative $ (undefined :: Four S S S (S,S,S))

  quickBatch $ monoid $ (undefined :: Four1 S (S,S,S))
  quickBatch $ functor $ (undefined :: Four1 S (S,S,S))
  quickBatch $ applicative $ (undefined :: Four1 S (S,S,S))






newtype Identity a = Identity a
  deriving (Eq, Show)

instance Functor Identity where
  fmap f (Identity x) = Identity (f x)

instance Applicative Identity where
  pure = Identity
  (<*>) (Identity f) (Identity x) = Identity (f x)

instance (Arbitrary a) => Arbitrary (Identity a) where
  arbitrary = pure Identity <*> arbitrary

instance (Eq a) => EqProp (Identity a) where
  (=-=) = eq






data Pair a = Pair a a
  deriving (Eq, Show)

instance Functor Pair where
  fmap f (Pair x z) = Pair (f x) (f z)

instance Applicative Pair where
  pure x = Pair x x
  (<*>) (Pair f1 f2) (Pair x z) = Pair (f1 x) (f2 z)

instance (Arbitrary a) => Arbitrary (Pair a) where
  arbitrary = do
    x <- arbitrary
    z <- arbitrary
    pure $ Pair x z

instance (Eq a) => EqProp (Pair a) where
  (=-=) = eq







data Two a b = Two a b
  deriving (Eq, Show)

instance (Monoid a, Monoid b) => Monoid (Two a b) where
  mempty = Two mempty mempty
  mappend (Two u s) (Two x z) = Two (mappend u x) (mappend s z)

instance Functor (Two a) where
  fmap f (Two x z) = Two x (f z)

instance (Monoid a) => Applicative (Two a) where
  pure x = Two mempty x
  (<*>) (Two u f) (Two x z) = Two (mappend u x) (f z)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    x <- arbitrary
    z <- arbitrary
    pure $ Two x z

instance (Eq a, Eq b) => EqProp (Two a b) where
  (=-=) = eq






data Three a b c = Three a b c
  deriving (Eq, Show)

instance Functor (Three a b) where
  fmap f (Three u x z) = Three u x (f z)

instance (Monoid a, Monoid b, Monoid c) => Monoid (Three a b c) where
  mempty = Three mempty mempty mempty
  mappend (Three v x z) (Three v' x' z') = Three (mappend v v') (mappend x x') (mappend z z')

instance (Monoid a, Monoid b) => Applicative (Three a b) where
  pure x = Three mempty mempty x
  (<*>) (Three v x f) (Three v' x' z) = Three (mappend v v') (mappend x x') (f z)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    v <- arbitrary
    x <- arbitrary
    z <- arbitrary
    pure $ Three v x z

instance (Eq a, Eq b, Eq c) => EqProp (Three a b c) where
  (=-=) = eq






data Three2 a b = Three2 a b b
  deriving (Eq, Show)

instance Functor (Three2 a) where
  fmap f (Three2 v x z) = Three2 v (f x) (f z)

instance (Monoid a, Monoid b) => Monoid (Three2 a b) where
  mempty = Three2 mempty mempty mempty
  mappend (Three2 v x z) (Three2 v' x' z') = Three2 (mappend v v') (mappend x x') (mappend z z')

instance (Monoid a) => Applicative (Three2 a) where
  pure x = Three2 mempty x x
  (<*>) (Three2 v f g) (Three2 v' x z) = Three2 (mappend v v') (f x) (g z)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three2 a b) where
  arbitrary = do
    v <- arbitrary
    x <- arbitrary
    z <- arbitrary
    pure $ Three2 v x z

instance (Eq a, Eq b) => EqProp (Three2 a b) where
  (=-=) = eq






data Four a b c d = Four a b c d
  deriving (Eq, Show)

instance Functor (Four a b c) where
  fmap f (Four z x v o) = Four z x v (f o)

instance (Monoid a, Monoid b, Monoid c, Monoid d) => Monoid (Four a b c d) where
  mempty = Four mempty mempty mempty mempty
  mappend (Four o v x z) (Four o' v' x' z') = Four (mappend o o') (mappend v v') (mappend x x') (mappend z z')

instance (Monoid a, Monoid b, Monoid c) => Applicative (Four a b c) where
  pure x = Four mempty mempty mempty x
  (<*>) (Four o v x f) (Four o' v' x' z) = Four (mappend o o') (mappend v v') (mappend x x') (f z)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = do
    o <- arbitrary
    v <- arbitrary
    x <- arbitrary
    z <- arbitrary
    pure $ Four o v x z

instance (Eq a, Eq b, Eq c, Eq d) => EqProp (Four a b c d) where
  (=-=) = eq






data Four1 a b = Four1 a a a b
  deriving (Eq, Show)

instance Functor (Four1 a) where
  fmap f (Four1 z x v o) = Four1 z x v (f o)

instance (Monoid a, Monoid b) => Monoid (Four1 a b) where
  mempty = Four1 mempty mempty mempty mempty
  mappend (Four1 o v x z) (Four1 o' v' x' z') = Four1 (mappend o o') (mappend v v') (mappend x x') (mappend z z')

instance (Monoid a) => Applicative (Four1 a) where
  pure x = Four1 mempty mempty mempty x
  (<*>) (Four1 o v x f) (Four1 o' v' x' z) = Four1 (mappend o o') (mappend v v') (mappend x x') (f z)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four1 a b) where
  arbitrary = do
    o <- arbitrary
    v <- arbitrary
    x <- arbitrary
    z <- arbitrary
    pure $ Four1 o v x z

instance (Eq a, Eq b) => EqProp (Four1 a b) where
  (=-=) = eq
