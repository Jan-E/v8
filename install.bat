C:
cd C:\projects
set v8_platform=x64
set v8_vstudio=VS2017
set v8_vcversion=vc15
set v8_toolset=v141
set v8_branch=lkgr
if exist depot_tools rd depot_tools /s /q
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
set PATH=C:\projects\depot_tools;C:\projects\depot_tools\v8;%PATH%
set GYP_MSVS_VERSION=2017
set VC=15
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set GYP_CHROMIUM_NO_ACTION=0
cd C:\projects\depot_tools
call fetch V8
cd C:\projects\depot_tools\v8
call git fetch origin master
call git checkout master
call git pull
call gclient sync
cd C:\projects
if exist depot_tools.7z del depot_tools.7z
7z.exe a depot_tools.7z depot_tools
cd C:\projects\depot_tools\v8\%v8_branch%\%v8_platform%.release
if exist api*.dll del api*.dll
if exist pgosweep.exe del pgosweep.exe
xcopy v8*.lib C:\projects\%v8_branch%-%v8_platform%-vc%VC%\lib\ /y
xcopy v8*.dll C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y
xcopy v8*.dll.pdb C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y > nul
xcopy icu*.lib C:\projects\%v8_branch%-%v8_platform%-vc%VC%\lib\ /y
xcopy icu*.dll C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y
xcopy icu*.dll.pdb C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y > nul
xcopy icu*.dat C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y > nul
xcopy *exe* C:\projects\%v8_branch%-%v8_platform%-vc%VC%\bin\ /y > nul
xcopy C:\projects\depot_tools\v8\include\*.h C:\projects\%v8_branch%-%v8_platform%-vc%VC%\include\ /s /y > nul
cd C:\projects
7z.exe a %v8_branch%-%v8_platform%-vc%VC%.7z %v8_branch%-%v8_platform%-vc%VC%
