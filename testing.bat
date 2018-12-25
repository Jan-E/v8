set v8_platform=x64
set v8_vstudio=VS2017
set v8_vcversion=vc15
set v8_toolset=v141
set v8_branch=lkgr
set PATH=C:\projects\depot_tools;C:\projects\depot_tools\v8;%PATH%
set GYP_MSVS_VERSION=2017
set VC=15
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set GYP_CHROMIUM_NO_ACTION=0
cd C:\projects\depot_tools\v8\%v8_branch%\%v8_platform%.release
rem failing in 7.1-lkgr (7.1.302.33)
cctest.exe test-heap/TestSizeOfObjectsVsHeapIteratorPrecision --random-seed=975877910 --no-turbo-verify-allocation --stress-opt --always-opt --nohard-abort
rem failing in 7.1-lkgr and lkgr
cctest.exe test-heap/MapRetaining --random-seed=975877910 --no-turbo-verify-allocation --stress-opt --always-opt --nohard-abort
inspector-test.exe ..\..\test\inspector\protocol-test.js ..\..\test\inspector\debugger/step-snapshot.js --random-seed=975877910 --no-turbo-verify-allocation --stress-opt --always-opt --nohard-abort --embed "function c(f, ...args) { return f(...args); }"
cctest.exe test-external-string-tracker/ExternalString_ExternalBackingStoreSizeIncreasesAfterExternalization --random-seed=975877910 --no-turbo-verify-allocation --stress-incremental-marking --nohard-abort
cd C:\projects\depot_tools\v8
call python tools/run-tests.py --progress=verbose --mode Release --outdir %v8_branch%\%v8_platform%.release --buildbot --timeout=200 --random-seed=975877910 bot_default --variants=more,dev --rerun-failures-count=2 --mastername client.v8 --buildername V8 Win64 - msvc --swarming > run-tests.txt
