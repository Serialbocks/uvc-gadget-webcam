import os

import subprocess
import time

directory = '/opt/uvc-gadget-webcam/'
driver_script = os.path.join(directory, 'rpi-uvc-gadget.sh')
uvc_gadget = os.path.join(directory, 'uvc-gadget -v /dev/video1 -u /dev/video0 -n3 -f0 -r0 -s1 -o1')
ffmpeg = 'ffmpeg -f rtsp -i rtsp://192.168.0.180:8554/webcam -pix_fmt yuyv422 -f v4l2 /dev/video1'

result = subprocess.run([driver_script, 'start'], capture_output=True, text=True)
print(result.stdout)

while True:
    
    ffmpeg_process = subprocess.Popen(ffmpeg.split(' '), start_new_session=True, stdout=subprocess.PIPE)
    time.sleep(12)
    uvc_process = subprocess.run(uvc_gadget.split(' '), capture_output=True, text=True)
    uvc_process.wait()
    print(result.stdout)
    # If UVC gadget program completes, kill ffmpeg and loop
    ffmpeg_process.kill()
    time.sleep(5)

