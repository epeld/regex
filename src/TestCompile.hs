module TestCompile (testCompile) where
import Test.HUnit

import TestUtils
import Compile

testRegexCompiles = testCases
    [ assertCompiles "a+",
      assertCompiles "a+b*",
      assertCompiles "xxy(a)+b*",
      assertCompiles "(xxy)*(a)+b*",
      assertFails "+" ]


--
-- DSL definitions 
--

assertCompiles :: String -> Assertion
assertCompiles rx = case Compile.compile rx of
    Left _ -> assertFailure (rx ++ " fails to compile")
    _ -> return ()

assertFails :: String -> Assertion
assertFails rx = case Compile.compile rx of
    Right _ -> assertFailure (rx ++ " compiles")
    _ -> return ()

-- Public interface
testCompile = "Compilation Tests" ~: testRegexCompiles
