#!/bin/bash
# Try things like "Slice Registers" or "Slice LUTs"
ag "$1" -Gutilization_synth.rpt | grep -v impl | sed -E 's/ +//g' | tr '/' '|' | cut -d '|' -f 2,5 | tr '|' ' ' | awk '{ print $2,$1 }' | sort -n