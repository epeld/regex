#!/bin/bash

set -e

cabal build -v0
./testregex
