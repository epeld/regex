module TestRegex where
import Test.HUnit.Base

import qualified Regex

testRegexMatch = testCases
    [ "a+" `assertFails` "a",
      "a+" `assertMatches` "a",
      "a+" `assertMatches` "aa" ]

testCases = TestList. map TestCase

assertMatches :: String -> String -> Assertion
assertMatches rx s =
    assertBool (unwords [rx, "matches", s]) (Regex.match rx s)

assertFails :: String -> String -> Assertion
assertFails rx s =
    assertBool (unwords [rx, "fails", s]) (not $ Regex.match rx s)

testRegex = "Regex Tests" ~: testRegexMatch 
