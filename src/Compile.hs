module Compile where

type Regex = String

data CompiledRegex = CompiledRegex State
data CompilationError = CompilationError

data State = MatchingState | IntermediateState Condition State (Maybe State)

data Condition = Condition

compile :: Regex -> Either CompilationError CompiledRegex 
compile [] = Right $ CompiledRegex MatchingState
compile s = Left CompilationError

match :: CompiledRegex -> String -> Maybe String
match (CompiledRegex s) = match_ s

match_ :: State -> String -> Maybe String
match_ MatchingState _ = Just ""
match_ s _ = Nothing
