#!/usr/bin/python

import pyopencl as cl
from time import sleep
from BitcoinMiner import *
from optparse import OptionParser

parser = OptionParser(version=USER_AGENT)
parser.add_option('-r', '--rate',     dest='rate',       default=1,           help='hash rate display interval in seconds, default=1', type='float')
parser.add_option('-f', '--frames',   dest='frames',     default=30,          help='will try to bring single kernel execution to 1/frames seconds, default=30, increase this for less desktop lag', type='int')
parser.add_option('-d', '--device',   dest='device',     default=-1,          help='use device by id, by default asks for device', type='int')
parser.add_option('-a', '--askrate',  dest='askrate',    default=5,           help='how many seconds between getwork requests, default 5, max 10', type='int')
parser.add_option('-w', '--worksize', dest='worksize',   default=-1,          help='work group size, default is maximum returned by opencl', type='int')
parser.add_option('-v', '--vectors',  dest='vectors',    action='store_true', help='use vectors')
parser.add_option('-s', '--sleep',    dest='frameSleep', default=0,           help='sleep per frame in seconds, default 0', type='float')
parser.add_option('-e', '--estimate', dest='estimate',   default=900,         help='estimated rate time window in seconds, default 900 (15 minutes)', type='int')
parser.add_option('--servers',        dest='servers',    default='',          help='list of servers: [https://]user:pass@host:port[,...]')
parser.add_option('--tolerance',      dest='tolerance',  default=2,           help='use fallback pool only after N consecutive connection errors, default 2', type='int')
parser.add_option('--failback',       dest='failback',   default=2,           help='attempt to fail back to the primary pool every N getworks, default 2', type='int')
parser.add_option('--verbose',        dest='verbose',    action='store_true', help='verbose output, suitable for redirection to log file')
parser.add_option('--platform',       dest='platform',   default=-1,          help='use platform by id', type='int')
(options, args) = parser.parse_args()

platforms = cl.get_platforms()


if options.platform >= len(platforms) or (options.platform == -1 and len(platforms) > 1):
	print 'Wrong platform or more than one OpenCL platforms found, use --platform to select one of the following\n'
	for i in xrange(len(platforms)):
		print '[%d]\t%s' % (i, platforms[i].name)
	sys.exit()

if options.platform == -1:
	options.platform = 0

devices = platforms[options.platform].get_devices()
if (options.device == -1 or options.device >= len(devices)):
	print 'No device specified or device not found, use -d to specify one of the following\n'
	for i in xrange(len(devices)):
		print '[%d]\t%s' % (i, devices[i].name)
	sys.exit()

miner = None
try:
	miner = BitcoinMiner(devices[options.device], options)
	miner.mine()
except KeyboardInterrupt:
	print '\nbye'
finally:
	if miner: miner.exit()
sleep(1.1)
