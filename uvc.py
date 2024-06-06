import os, sys
import subprocess
import time

result = subprocess.run(['/home/john/rpi-uvc-gadget.sh', 'start'], capture_output=True, text=True)
print(result.stdout)
result = subprocess.Popen(['/home/john/mediamtx'], start_new_session=True)
print('Started mediamtx')

result = subprocess.run(['uvc-prog/uvc-gadget', '-v', '/dev/video1', '-u', '/dev/video0', '-n3', '-f0', '-r0', '-s1', '-o1'], capture_output=True, text=True)
print(result.stdout)
