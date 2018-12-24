C:
cd C:\projects
if exist depot_tools rd depot_tools /s /q
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
set PATH=C:\projects\depot_tools;%PATH%
set GYP_MSVS_VERSION=2017
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
