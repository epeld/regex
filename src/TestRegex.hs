module TestRegex (testRegex) where
import Test.HUnit

import TestUtils
import qualified Regex

testRegexMatch = testCases
    [ "a+" `assertFails` "a",
      "a+" `assertMatches` "a",
      "a+" `assertMatches` "aa" ]

--
-- DSL Definitions
--

assertMatches :: String -> String -> Assertion
assertMatches rx s =
    assertBool (unwords [rx, "matches", s]) (Regex.match rx s)

assertFails :: String -> String -> Assertion
assertFails rx s =
    assertBool (unwords [rx, "fails", s]) (not $ Regex.match rx s)

-- Public interface

testRegex = "Regex Tests" ~: testRegexMatch 
