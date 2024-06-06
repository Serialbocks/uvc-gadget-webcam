import os
import subprocess
import time

directory = '/opt/uvc-gadget-webcam/'
driver_script = os.path.join(directory, 'rpi-uvc-gadget.sh')
mediamtx = os.path.join(directory, 'mediamtx')
uvc_gadget = os.path.join(directory, 'uvc-gadget')

result = subprocess.run([driver_script, 'start'], capture_output=True, text=True)
print(result.stdout)
result = subprocess.Popen([mediamtx], start_new_session=True)
print('Started mediamtx')

while True:
    time.sleep(3)
    result = subprocess.run([uvc_gadget, '-v', '/dev/video1', '-u', '/dev/video0', '-n3', '-f0', '-r0', '-s1', '-o1'], capture_output=True, text=True)
    print(result.stdout)


