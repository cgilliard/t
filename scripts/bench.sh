#!/bin/sh

set -e

# 64 MiB: the device benches stride 0x40 sectors apart over 1000 requests, so they
# span ~31 MiB (see "bench sector geometry" in src/disk.fam).  Sized with headroom;
# shrink this and bfits skips the device benches rather than letting them benchmark
# out-of-range requests that fail fast and look like a speedup.
dd if=/dev/zero of=./tmp/bench_disk.img bs=1M count=64 2>/dev/null
./tools/fam --bench --net --hostfwd=udp::47653-:47653 `cat scripts/files.txt` --disk=./tmp/bench_disk.img
