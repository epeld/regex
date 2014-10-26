module TestRegex (testRegex) where
import Test.HUnit

import TestUtils
import qualified Regex

testRegexMatch = testCases
    [ "" `assertMatches` "anything",
      "a+" `assertFails` "a",
      "a+" `assertMatches` "a",
      "a+" `assertMatches` "aa" ]

--
-- DSL Definitions
--

assertMatches :: String -> String -> Assertion
assertMatches rx s =
    assertBool (unwords [rx, "matches", s]) (Regex.matches rx s)

assertFails :: String -> String -> Assertion
assertFails rx s =
    assertBool (unwords [rx, "fails", s]) (not $ Regex.matches rx s)

-- Public interface

testRegex = "Regex Tests" ~: testRegexMatch 
