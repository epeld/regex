module Compile where
import Regex

data CompiledRegex = CompiledRegex
data CompilationError = CompilationError

compile :: Regex -> Either CompilationError CompiledRegex 
compile s = Left CompilationError
