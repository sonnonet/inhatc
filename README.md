# inhatc
# InfluxDB Installation

## 0. 라즈베이파이 업데이트
```
  sudo apt update
  sudo apt upgrade
```
## 1. Repository의 GPG key를 더하기

```
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -

```

## 2. Repository를 더하기

```
echo "deb https://repos.influxdata.com/debian stretch stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
```

## 3. 프로그램 설치
```
sudo apt update
sudo apt install influxdb
```
## 3.1 프로그램 실행 전 설정
```
sudo systemctl unmask influxdb
sudo systemctl enable influxdb
sudo systemctl start influxdb
```

## 4. 데이터베이스 만들기
```
>create database <데이터베이스이름>
```
```
확인 : show databases 
```
# Grafana Installation

## 1. Repository의 GPG key를 더하기
```
curl https://bintray.com/user/downloadSubjectPublicKey?username=bintray | sudo apt-key add -
```

## 2. Repository를 더하기
```
echo "deb https://dl.bintray.com/fg2it/deb stretch main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
```

## 3. 프로그램 설치
```
sudo apt update
sudo apt install grafana
```

## 4. 프로그램 실행
```
sudo service grafana-server start
```
## influxdb import with python
```
sudo pip install influxdb
```
## gpio pin map
```
cd /tmp
wget https://project-downloads.drogon.net/wiringpi-latest.deb
sudo dpkg -i wiringpi-latest.deb
```
