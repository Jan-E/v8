cd \projects\depot_tools\v8
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
call git fetch origin %v8_branch%
call git checkout %v8_branch%
call git pull --depth 1
call gclient sync
call gn gen %v8_branch%\%v8_platform%.release --args="is_component_build=true is_debug=false v8_use_snapshot=false target_cpu=\"%v8_platform%\"" --ide=vs
type %v8_branch%\%v8_platform%.release\args.gn
call ninja -C %v8_branch%\%v8_platform%.release
cd C:\projects
if exist depot_tools.7z del depot_tools.7z
7z.exe a depot_tools.7z depot_tools
cd C:\projects\depot_tools\v8\%v8_branch%\%v8_platform%.release
dir *.exe *.dll *.lib
