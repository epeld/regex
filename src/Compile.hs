module Compile where
import Data.Traversable
import Control.Monad

import State

type Regex = String

data CompiledRegex = CompiledRegex [State]
data CompilationError = InvalidEscape | CompilationError


compile :: Regex -> Either CompilationError CompiledRegex 
compile rx = liftM CompiledRegex $ compile_ rx

compile_ :: Regex -> Either CompilationError [State]
compile_ "" = Right []
compile_ ('\\':xs) = case xs of
    (x : xs') -> stateWithCharacter x : compile_ xs
    [] -> Left InvalidEscape

compile_ s = Left CompilationError

match :: CompiledRegex -> String -> Maybe String
match (CompiledRegex s) = match_ s

match_ :: [State] -> String -> Maybe String
match_ [] _ = Just ""
match_ s _ = Nothing

