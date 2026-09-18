#!/bin/sh

set -e

dd if=/dev/zero of=./tmp/bench_disk.img bs=1M count=1 2>/dev/null
./tools/fam --bench --net --hostfwd=udp::47653-:47653 `cat scripts/files.txt` --disk=./tmp/bench_disk.img
