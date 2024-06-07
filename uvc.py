import os
import signal
import subprocess
import time

directory = '/opt/uvc-gadget-webcam/'
driver_script = os.path.join(directory, 'rpi-uvc-gadget.sh')
#mediamtx = os.path.join(directory, 'mediamtx')
uvc_gadget = os.path.join(directory, 'uvc-gadget -v /dev/video1 -u /dev/video0 -n3 -f0 -r0 -s1 -o1')
vlc = 'cvlc --no-video rtsp://192.168.0.180:8554/webcam'

result = subprocess.run([driver_script, 'start'], capture_output=True, text=True)
print(result.stdout)
#result = subprocess.Popen([mediamtx], start_new_session=True)
#print('Started mediamtx')

while True:
    time.sleep(5)
    vlc_process = subprocess.Popen(vlc.split(' '), shell=True, stdout=subprocess.PIPE, start_new_session=True, preexec_fn=os.setsid)
    result = subprocess.run(uvc_gadget.split(' '), capture_output=True, text=True)
    print(result.stdout)
    os.killpg(os.getpgid(vlc_process.pid), signal.SIGTERM)  # If UVC gadget program completes, kill the VLC one and try again

