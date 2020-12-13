# The ApoCLypse FPGA Bitcoin Miner

## Background
This is forked from [JustinTArthur/apoclypsebm](https://github.com/JustinTArthur/apoclypsebm) with the aim to modify it to work with OpenCL-ready FPGA Accelerators.

## Maintainers and Donations

The list of current maintainers and contributors to this project.

| Name                  | Contact                   |                                                              |
| --------------------- | ------------------------- | ------------------------------------------------------------ |
| M. Khaled     | [@mkhaled87](https://github.com/mkhaled87)     | BTC: 1MKHALEDqXhBzqa86hj8FbDGW5HvDdA5Tq,<br />ETH: 0x14551935EDf4aF06909336084412dd805aE14b26|



## Installation
In an environment with Python 3.5+:

    pip3 install apoclypsebm

## Usage
    apoclypse [OPTION]... SERVER[#tag]...

`SERVER` is one or more [http[s]|stratum://]user:pass@host:port (required)  
[#tag] is an optional per server user-friendly name displayed in stats.

### Options
```
Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  --verbose             verbose output, suitable for redirection to log file
  -q, --quiet           suppress all output except hash rate display
  --proxy=PROXY         specify as
                        [[socks4|socks5|http://]user:pass@]host:port (default
                        proto is socks5)
  --no-ocl              don't use OpenCL
  --no-bfl              don't use Butterfly Labs
  --stratum-proxies     search for and use stratum proxies in subnet
  -d DEVICE, --device=DEVICE
                        comma separated device IDs, by default will use all
                        (for OpenCL - only GPU devices)
  -a ADDRESS, --address=ADDRESS
                        Bitcoin address to spend the block reward to if
                        allowed. Required for solo mining, ignored with
                        stratum or getwork sources.
  --coinbase-msg=COINBASE_MSG
                        Custom text to include in the coinbase of the
                        generation tx if allowed, encoded as UTF-8.
                        default=ApoCLypse

  Miner Options:
    -r RATE, --rate=RATE
                        hash rate display interval in seconds, default=1 (60
                        with --verbose)
    -e ESTIMATE, --estimate=ESTIMATE
                        estimated rate time window in seconds, default 900 (15
                        minutes)
    -t TOLERANCE, --tolerance=TOLERANCE
                        use fallback pool only after N consecutive connection
                        errors, default 2
    -b FAILBACK, --failback=FAILBACK
                        attempt to fail back to the primary pool after N
                        seconds, default 60
    --cutoff-temp=CUTOFF_TEMP
                        AMD GPUs, BFL only. For GPUs requires
                        github.com/mjmvisser/adl3. Comma separated
                        temperatures at which to skip kernel execution, in C,
                        default=95
    --cutoff-interval=CUTOFF_INTERVAL
                        how long to not execute calculations if CUTOFF_TEMP is
                        reached, in seconds, default=0.01
    --no-server-failbacks
                        disable using failback hosts provided by server

  OpenCL Options:
    Every option except 'platform' and 'vectors' can be specified as a
    comma separated list. If there aren't enough entries specified, the
    last available is used. Use --vv to specify per-device vectors usage.

    -p PLATFORM, --platform=PLATFORM
                        use platform by id
    -k KERNEL, --kernel=KERNEL
                        OpenCL Kernel to use. Defaults to apoclypse-0
    -w WORKSIZE, --worksize=WORKSIZE
                        work group size, default is maximum reported by the
                        driver.
    -f FRAMES, --frames=FRAMES
                        will try to bring single kernel execution to 1/frames
                        seconds, default=30, increase this for less desktop
                        lag
    -s FRAME_SLEEP, --sleep=FRAME_SLEEP
                        sleep per frame in seconds, default 0
    --vv=VECTORS        Specifies size of SIMD vectors per selected device.
                        Only size 0 (no vectors) and 2 supported for now.
                        Comma separated for each device. e.g. 0,2,2
    -v, --vectors       Use 2-item vectors for all devices.
```

### Examples
Solo mining against a Bitcoin Core node's RPC port:

    apoclypse --address bc1qf2277gpv3hlewlqq2cuvf77qz5xcjzr7njf3s9 --verbose http://u:p@127.0.0.1:8332

Mining on OpenCL platform 0, device 1 against a stratum server:

    apoclypse -p 0 -d 1 --verbose stratum://u:p@us-east.stratum.hushpool.io:3333
    
mining on f2pool example;

    apoclypse -p 0 -d 0 --verbose stratum+tcp://mkhaled87.001:21235365876986800@btc-eu.f2pool.com:3333
