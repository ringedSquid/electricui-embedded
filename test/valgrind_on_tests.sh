#!/bin/bash

# Copyright (c) 2016-2019 Electric UI
# MIT Licenced - see LICENCE for details.

# Incredibly naive script, runs valgrind on binaries generated by ceedling, as these cover most functionality
# Requires valgrind to be installed on your system

mkdir -p "build/test/out/grind-logs"

for binary in build/test/out/*.out
do
  [ -e "$binary" ] || continue
  printf '\nRunning valgrind on %s\n' "$binary"
  
  valgrind --log-file="build/test/out/grind-logs/$(basename "$binary" .out).log" -v --leak-check=full "${binary}" >/dev/null
  cat "build/test/out/grind-logs/$(basename "$binary" .out).log"

  printf 'Valgrind output located at %s\n' "build/test/out/grind-logs/$(basename "$binary" .out).log"
done