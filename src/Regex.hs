module Regex where
import Data.Maybe

import qualified Compile


match rx s = case Compile.compile rx
    of Left err -> error $ "Can't compile regex " ++ rx
       Right crx -> Compile.match crx s

matches rx s = isJust (match rx s)
