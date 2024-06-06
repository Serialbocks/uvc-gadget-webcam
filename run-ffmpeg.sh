ffmpeg -f rtsp -i rtsp://127.0.0.1:8554/webcam -pix_fmt yuyv422 -f v4l2 /dev/video1
#sleep(8)
#/opt/uvc-gadget-webcam/uvc-gadget -v /dev/video1 -u /dev/video0 -n3 -f0 -r0 -s1 -o1
