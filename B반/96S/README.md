## 라즈베리파이 OpenCV 설치

1. 라즈베리파이 최신 업데이트 
  ```
  sudo apt-get update && sudo apt-get upgrade
  ```
  
2. OpenCV 컴파일에 필요한 패키지 설치
  ```
  sudo apt-get install build-essential cmake pkg-config
  sudo apt-get install libjpeg-dev libtiff5-dev libpng12-dev
  sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libx264-dev libxine2-dev
  sudo apt-get install libv4l-dev v4l-utils
  sudo apt-get install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
  sudo apt-get install libgtk2.0-dev
  sudo apt-get install mesa-utils libgl1-mesa-dri libgtkgl2.0-dev libgtkglext1-dev
  sudo apt-get install libatlas-base-dev gfortran libeigen3-dev
  sudo apt-get install python3-dev python3-numpy
  
  ```

3. OpenCV 설치
- 소스코드 다운로드
  ```
  mkdir opencv
  wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.3.zip
  wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.3.zip
  ```
- 압축해제
  ```
  unzip opencv.zip
  unzip opencv_contrib.zip
  ```
  
- Build 폴더 생성
  ```
  cd opencv-3.4.3
  mkdir build
  cd build
  ```
- make option 설정
```
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D WITH_TBB=OFF \
-D WITH_IPP=OFF \
-D WITH_1394=OFF \
-D BUILD_WITH_DEBUG_INFO=OFF \
-D BUILD_DOCS=OFF \
-D INSTALL_C_EXAMPLES=ON \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D BUILD_EXAMPLES=OFF \
-D BUILD_TESTS=OFF \
-D BUILD_PERF_TESTS=OFF \
-D ENABLE_NEON=ON \
-D WITH_QT=OFF \
-D WITH_GTK=ON \
-D WITH_OPENGL=ON \
-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.4.3/modules \
-D WITH_V4L=ON  \
-D WITH_FFMPEG=ON \
-D WITH_XINE=ON \
-D BUILD_NEW_PYTHON_SUPPORT=ON \
../
```

- Swap 메모리 확보 (1G)
```
free
sudo vim /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile restart
free
```
- make
```
time make -j4
```
- Install
```
sudo make install 
```
- 확인
```
cat /etc/ld.so.conf.d/*
sudo ldconfig
sudo vim /etc/dphys-swapfile   -swap 용량 원래 설정으로 변경
sudo /etc/init.d/dphys-swapfile restart
free
pkg-config --modversion opencv   -opencv 버전확인
```
- python 확인
```
python 
import cv2
cv2.__version__
```

- /usr/local/lib 없을시
```
sudo sh -c 'echo 'usr/local/lib' /etc/ld.so.conf.d/opencv.conf'
```

### 참고 사이트
[카메라를 사용하여 얼굴 인식하기] (https://blog.naver.com/nospaces/221843095703)




