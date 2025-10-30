ffmpeg -re -stream_loop -1 -i test.mp4 -c copy -f rtsp rtsp://127.0.0.1:8554/mystream
#ffmpeg -re -stream_loop -1 -i test.mp4 -c copy -f rtsp rtsp://172.17.0.2:8554/mystream

