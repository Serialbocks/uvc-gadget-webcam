import os
import signal
import subprocess
import time

directory = '/opt/uvc-gadget-webcam/'
driver_script = os.path.join(directory, 'rpi-uvc-gadget.sh')
#mediamtx = os.path.join(directory, 'mediamtx')
uvc_gadget = os.path.join(directory, 'uvc-gadget -v /dev/video1 -u /dev/video0 -n3 -f0 -r0 -s1 -o1')
vlc = 'cvlc --no-video rtsp://192.168.0.180:8554/webcam'
ffmpeg = 'ffmpeg -f rtsp -i rtsp://192.168.0.180:8554/webcam -pix_fmt yuyv422 -f v4l2 /dev/video1'

result = subprocess.run([driver_script, 'start'], capture_output=True, text=True)
print(result.stdout)
#result = subprocess.Popen([mediamtx], start_new_session=True)
#print('Started mediamtx')

while True:
    time.sleep(5)
    ffmpeg_process = subprocess.Popen(ffmpeg.split(' '), shell=True, stdout=subprocess.PIPE, start_new_session=True, preexec_fn=os.setsid)
    vlc_process = subprocess.Popen(vlc.split(' '), shell=True, stdout=subprocess.PIPE, start_new_session=True, preexec_fn=os.setsid)
    result = subprocess.run(uvc_gadget.split(' '), capture_output=True, text=True)
    print(result.stdout)
    # If UVC gadget program completes, kill the FFMPEG and VLC processes and try again
    os.killpg(os.getpgid(vlc_process.pid), signal.SIGTERM)
    os.killpg(os.getpgid(ffmpeg_process.pid), signal.SIGTERM)

