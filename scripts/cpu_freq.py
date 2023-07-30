#!/bin/python

import psutil
import time

time.sleep(1.5)
print('󰓅 ' + '{:>.0f}'.format(psutil.cpu_freq().current) + 'MHz')
