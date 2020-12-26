@echo off

set PYTHONPATH=.\

set ACCOUNT=mkhaled87
set WORKER=001
set ACCOUNT_PASSWORD=21235365876986800
set MINING_POOL=btc.f2pool.com
set POOL_PORT=1314

set TARGET_PLATFORM_ID=0
set TARGET_DEVICE_ID=0
set LOCAL_WG_SIZE=256
SET NUM_CUS=11
set BINARY_FILE="D:\myWorkspace\GitLab\clypse_fpga\apoclypsebm\bin\s10_sh2e1_4Gx2_cu%NUM_CUS%\apoclypse_lws%LOCAL_WG_SIZE%.aocx"

cls
@echo Starting the BTC miner with CU=%NUM_CUS%/LWS=%LOCAL_WG_SIZE%
python .\apoclypsebm\command.py  -p %TARGET_PLATFORM_ID% -d %TARGET_DEVICE_ID% -i %BINARY_FILE% -w %LOCAL_WG_SIZE% --verbose stratum+tcp://%ACCOUNT%.%WORKER%:%ACCOUNT_PASSWORD%@%MINING_POOL%:%POOL_PORT%