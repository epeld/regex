import Test.HUnit

import TestRegex
import TestCompile

main = runTestTT $ TestList [ testRegex, testCompile ]
