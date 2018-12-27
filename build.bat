C:
cd \projects\depot_tools\v8
set v8_platform=x64
set v8_vstudio=VS2017
set v8_vcversion=vc15
set v8_toolset=v141
set v8_branch=lkgr
@set PATH=C:\projects\depot_tools;C:\projects\depot_tools\v8;%PATH%
set GYP_MSVS_VERSION=2017
set VC=15
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set GYP_CHROMIUM_NO_ACTION=0
call git fetch origin %v8_branch%
call git checkout %v8_branch%
call git pull --depth 1
call gclient sync
rem https://github.com/nodejs/node/blob/master/common.gypi#L45
call gn gen %v8_branch%\%v8_platform%.release --args="is_component_build=true is_debug=false v8_use_snapshot=true v8_deprecation_warnings=true v8_imminent_deprecation_warnings=true v8_enable_disassembler=true v8_use_external_startup_data=false v8_enable_handle_zapping=false v8_untrusted_code_mitigations=false v8_enable_pointer_compression=false v8_enable_embedded_builtins=true v8_enable_fast_mksnapshot=false v8_enable_verify_heap=true target_cpu=\"%v8_platform%\"" --ide=vs
type %v8_branch%\%v8_platform%.release\args.gn
call ninja -C %v8_branch%\%v8_platform%.release
@echo on
cd C:\projects\depot_tools\v8\%v8_branch%\%v8_platform%.release
if exist api*.dll del api*.dll
if exist pgo*.* del pgo*.*
if exist vc*.* del vc*.*
if exist msvc*.* del msvc*.*
if exist ucrt*.* del ucrt*.*
if exist dbg*.* del dbg*.*
cd C:\projects
if exist depot_tools.7z del depot_tools.7z
7z.exe a -mx9 depot_tools.7z depot_tools
cd C:\projects\depot_tools\v8\%v8_branch%\%v8_platform%.release
if exist C:\projects\%v8_branch%-%v8_platform%-vc%VC% rd C:\projects\%v8_branch%-%v8_platform%-vc%VC% /s /q
xcopy v8*.lib C:\projects\%v8_branch%-%v8_platform%-vc%VC%\lib\ /y
xcopy v8*.dll C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y
xcopy v8*.dll.pdb C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y
xcopy icu*.lib C:\projects\%v8_branch%-%v8_platform%-vc%VC%\lib\ /y
xcopy icu*.dll C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y
xcopy icu*.dll.pdb C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y
xcopy icu*.dat C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y
xcopy *exe* C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y
xcopy C:\projects\depot_tools\v8\include\*.h C:\projects\%v8_branch%-%v8_platform%-vc%VC%\include\ /s /y
cd C:\projects
7z.exe a -mx9 %v8_branch%-%v8_platform%-vc%VC%.7z %v8_branch%-%v8_platform%-vc%VC%
