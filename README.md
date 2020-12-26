# The ApoCLypse FPGA Bitcoin Miner

## Background
This is forked from [JustinTArthur/apoclypsebm](https://github.com/JustinTArthur/apoclypsebm) modified to work with OpenCL-ready FPGA Accelerators.

## Maintainers and Donations

The list of current maintainers and contributors to this project.

| Name                  | Contact                   |                                                              |
| --------------------- | ------------------------- | ------------------------------------------------------------ |
| M. Khaled     | [@mkhaled87](https://github.com/mkhaled87)     | BTC: 1MKHALEDqXhBzqa86hj8FbDGW5HvDdA5Tq,<br />ETH: 0x14551935EDf4aF06909336084412dd805aE14b26|


## Tested Devices
| Device                | Details                                                       | Hashrates                           |
| --------------------- | ------------------------------------------------------------- | ----------------------------------- |
| Terasic DE10-Pro<br /><img src="https://www.terasic.com.tw/attachment/archive/1144/image/RevB_45.jpg" width="100">| Type: Accelerator/FPGA<br />FPGA: Stratix 10 GX/SX<br />RAM: 8 GB DDR4<br />More details: [Terasic website](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=13&No=1144&PartNo=1) | s10_sh2e1_4Gx2 (11 CU)/LWS_256: 4.3 Gh/s. |

## Installation and Usage
In an environment with Python 3.5+:

    pip3 install pyopencl
    
On Windows, if you face errors with the installation of pyopencl (as a dependency of apoclypsebm), copy the OpenCL include folder "CL\" from the FPGA implementation to the include folde rof your Python installation. You may also need to copy the OpenCL.lib to some place known to VS or the compoiler installed.

I had to also copy the "OpenCL.dll" from my FPGA installation and move it inside the installatioon of PyOpenCL so that loading "_cl.cp38-win_amd64.pyd" does not cause expection of missing DLL.

Now, you need to build the binaries for your target FPGA. Check the list of tested devices below and their build scrips.

We will be using ApoClypse directly from source. Once ready to run the miner, you have to navigate to the project root and set the Python path to it before running the miner:

In Windows (e.g., PowerShell)
    set PYTHONPATH=.\

In Linux
    PYTHONPATH=.

Now, run the miner as follows:

    python .\apoclypsebm\command.py [OPTION] -i BIN_FILE ... SERVER[#tag]...

`BIN_FILE` is a binary file of the kernel built for the target FPGA.
`SERVER` is one or more [http[s]|stratum://]user:pass@host:port (required)  
[#tag] is an optional per server user-friendly name displayed in stats.


### Examples
Solo mining against a Bitcoin Core node's RPC port:

    set PYTHONPATH=.\
    python .\apoclypsebm\command.py --address bc1qf2277gpv3hlewlqq2cuvf77qz5xcjzr7njf3s9 --verbose http://u:p@127.0.0.1:8332

Mining on OpenCL platform 0, device 1 against a stratum server:

    set PYTHONPATH=.\
    python .\apoclypsebm\command.py -p 0 -d 1 --verbose stratum://u:p@us-east.stratum.hushpool.io:3333
    
mining on f2pool example;

    set PYTHONPATH=.\
    python .\apoclypsebm\command.py -p 0 -d 0 --verbose stratum+tcp://mkhaled87.001:21235365876986800@btc-eu.f2pool.com:3333
