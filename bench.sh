hyperfine -w 1 \
  -n esbuild-cache \
  --prepare "" \
  "YARNPKG_TRANSPILER=esbuild node ./scripts/run-yarn.js exec yarn -v" \
  -n esbuild-no-cache \
  --prepare "rm -r ./node_modules/.cache/yarn" \
  "YARNPKG_TRANSPILER=esbuild node ./scripts/run-yarn.js exec yarn -v" \
  -n esbuild-partial-cache \
  --prepare "echo '//' | tee -a packages/yarnpkg-core/sources/*.ts" \
  "YARNPKG_TRANSPILER=esbuild node ./scripts/run-yarn.js exec yarn -v" \
  -n babel-cache \
  --prepare "" \
  "YARNPKG_TRANSPILER=babel node ./scripts/run-yarn.js exec yarn -v" \
  -n babel-no-cache \
  --prepare "rm -r /tmp/babel" \
  "YARNPKG_TRANSPILER=babel node ./scripts/run-yarn.js exec yarn -v" \
  -n babel-partial-cache \
  --prepare "echo '//' | tee -a packages/yarnpkg-core/sources/*.ts" \
  "YARNPKG_TRANSPILER=babel node ./scripts/run-yarn.js exec yarn -v"

# Benchmark 1: esbuild-cache
#   Time (mean ± σ):      4.280 s ±  0.053 s    [User: 5.142 s, System: 0.432 s]
#   Range (min … max):    4.245 s …  4.416 s    10 runs

# Benchmark 2: esbuild-no-cache
#   Time (mean ± σ):      6.374 s ±  0.031 s    [User: 5.684 s, System: 0.514 s]
#   Range (min … max):    6.337 s …  6.438 s    10 runs

# Benchmark 3: esbuild-partial-cache
#   Time (mean ± σ):      5.482 s ±  0.131 s    [User: 5.729 s, System: 0.508 s]
#   Range (min … max):    5.331 s …  5.667 s    10 runs

# Benchmark 4: babel-cache
#   Time (mean ± σ):      6.626 s ±  0.145 s    [User: 8.551 s, System: 0.621 s]
#   Range (min … max):    6.411 s …  6.812 s    10 runs

# Benchmark 5: babel-no-cache
#   Time (mean ± σ):     11.912 s ±  0.501 s    [User: 17.095 s, System: 0.816 s]
#   Range (min … max):   11.464 s … 12.971 s    10 runs

# Benchmark 6: babel-partial-cache
#   Time (mean ± σ):      7.579 s ±  0.083 s    [User: 10.345 s, System: 0.717 s]
#   Range (min … max):    7.444 s …  7.710 s    10 runs

# Summary
#   'esbuild-cache' ran
#     1.28 ± 0.03 times faster than 'esbuild-partial-cache'
#     1.49 ± 0.02 times faster than 'esbuild-no-cache'
#     1.55 ± 0.04 times faster than 'babel-cache'
#     1.77 ± 0.03 times faster than 'babel-partial-cache'
#     2.78 ± 0.12 times faster than 'babel-no-cache'
