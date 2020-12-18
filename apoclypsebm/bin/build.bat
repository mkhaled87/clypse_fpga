@echo OFF

rem All paths must be relative to current folder !
SET BOARD=s10_sh2e1_4Gx2
SET KERNEL_FILE=apoclypse.cl
SET NUM_CUS=8
SET TARGET_LWS=256 128 64
SET OUT_BIN_FOLDER=.\%BOARD%_cu%NUM_CUS%

cls
echo -----------------------------------------------------------------------------------------------------------
echo Building Kernel (%KERNEL_FILE%) for Intel FPGA (board=%BOARD%) using Intel OpenCL offline complier (AOC)
echo Targeted number of compute units: %NUM_CUS%
echo Targeted local work group sizes (LWS): %TARGET_LWS%
echo This should run as administrator !
echo -----------------------------------------------------------------------------------------------------------

if not exist "%OUT_BIN_FOLDER%\" mkdir %OUT_BIN_FOLDER%
if not exist ".\tmp\" mkdir .\tmp
cd tmp 

for %%x in (%TARGET_LWS%) do (
    echo.
    echo -- Building kernel %KERNEL_FILE% for LWS=%%x (Started: %date% %time%
    aoc ..\%KERNEL_FILE% -DNUM_CUS=%NUM_CUS% -DWORKSIZE=%%x -o .\apoclypse_lws%%x.aocx -board=%BOARD% -v
    if exist .\apoclypse_lws%%x.aocx (
        move .\apoclypse_lws%%x.aocx ..\%OUT_BIN_FOLDER%\apoclypse_lws%%x.aocx
        echo -- AOCX Build done and AOCX file moved to: %OUT_BIN_FOLDER%\apoclypse_lws%%x.aocx
    ) else (
        echo -- AOCX Build failed. See the log above.
    )
    echo.
)

cd ..
del /F/Q/S .\tmp\*.* > NUL
rmdir /S/Q .\tmp > NUL
