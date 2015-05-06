#!/bin/sh
find "$@" -xdev -depth | awk '{
    depth = $0; gsub(/[^\/]/, "", depth); depth = length(depth);
    if (depth < previous_depth) {
       # A non-empty directory: its predecessor was one of its files
       total[depth] += total[previous_depth];
       print total[previous_depth] + 1, $0;
       total[previous_depth] = 0;
    }
    ++total[depth];
    previous_depth = depth;
}
END { print total[0], "total"; }'
