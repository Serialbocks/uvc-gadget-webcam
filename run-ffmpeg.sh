ffmpeg -f rtsp -i rtsp://192.168.0.180:8554/webcam -pix_fmt yuyv422 -f v4l2 /dev/video1
