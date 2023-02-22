@echo off

if exist "C:\Program Files (x86)\VMD" (
	SET VMDDIR="C:\Program Files (x86)\VMD"
	echo VMD        was found in %VMDDIR%
) else if exist "C:\Program Files\VMD" (
	SET VMDDIR="C:\Program Files\VMD"
	echo VMD        was found in %VMDDIR%
) else (
	echo Warning! VMD installation was not found.
	echo Install  VMD and try again.
	exit /b 1
)

if exist "C:\Program Files (x86)\OpenBabel-2.4.1" (
	SET BABELHOME="C:\Program Files (x86)\OpenBabel-2.4.1"
	echo OpenBabel  was found in %BABELHOME%
) else if exist "C:\Program Files\OpenBabel-2.4.1" (
	SET BABELHOME="C:\Program Files\OpenBabel-2.4.1"
	echo OpenBabel  was found in %BABELHOME%
) else (
	echo Warning! OpenBabel installation was not found.
	echo Install  OpenBabel-3.1.1 and try again.
	exit /b 1
)

SET MAIN_ROOT=C:\opt

if not exist %MAIN_ROOT% (
	echo * creating  %MAIN_ROOT%
	mkdir %MAIN_ROOT%
)

if exist %MAIN_ROOT%\topolbuild (
	echo topolBuild was found in %MAIN_ROOT%\topolbuild
) else (
	echo ** installing topolBuild
	curl -OL https://github.com/makoto-yoneya/topolbuild-nohrenum/releases/download/1.3.1/topolbuild-1.3-mingw.zip
	call powershell -command "Expand-Archive  topolbuild-1.3-mingw.zip %MAIN_ROOT%"
	del topolbuild-1.3-mingw.zip
)

if exist %MAIN_ROOT%\gromacs (
	echo gromacs    was found in %MAIN_ROOT%\gromacs
) else (
	echo *** installing gromacs
	curl -OL https://github.com/makoto-yoneya/gromacs-MSVC/releases/download/2019.6.win32/gromacs-2019.6-win32.zip
	call powershell -command "Expand-Archive  gromacs-2019.6-win32.zip %MAIN_ROOT%"
	del gromacs-2019.6-win32.zip
)

REM echo moving to home
chdir %HOMEPATH%

if exist GMXRC.bat (
	echo deleating old GMXRC.bat
	del GMXRC.bat
)

if not exist GMXRC.bat (
	echo creating  new GMXRC.bat
	echo @echo off > GMXRC.bat
	echo REM >> GMXRC.bat
	echo REM Open DOS window with specified PATH setting. >> GMXRC.bat
	echo REM >> GMXRC.bat
	echo SET MAIN_ROOT=%MAIN_ROOT%>> GMXRC.bat
	echo SET BABELHOME=%BABELHOME%>> GMXRC.bat
	echo SET VMDDIR=%VMDDIR%>> GMXRC.bat
	echo SET TBHOME=%%MAIN_ROOT%%\topolbuild>> GMXRC.bat
	echo SET GMXHOME=%%MAIN_ROOT%%\gromacs>> GMXRC.bat
	echo SET GMXDATA=%%GMXHOME%%\share\gromacs;%%TBHOME%%\water_and_ions>> GMXRC.bat
	echo SET GMXLIB=%%GMXHOME%%\share\gromacs\top;%%TBHOME%%\water_and_ions>> GMXRC.bat
	echo SET PATH=%%GMXHOME%%\bin;%%TBHOME%%;%%VMDDIR%%;%%BABELHOME%%;%%PATH%%>> GMXRC.bat
	echo IF "%%1" EQU "" %%windir%%\system32\cmd.exe>> GMXRC.bat
)
