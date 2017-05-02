# Tensorflow installing script

## Introduction
This scrip install tensorflow-gpu automatically, it can install
ipython2 

ipython3

pip2

pip3

tensorflow-gpu in python2

tensorflow-gpu in python3

other dependencies

in Ubuntu 14.04 and 16.04(tested)


## Settings
If you have proxy such as shadowsocks you can set 

USE_PROXYCHAIN=1

and set the proxy server's protocol, ip and port

PROXY_SERVER='http\t127.0.0.1:1080'

or 

PROXY_SERVER='socks\t127.0.0.1:1080'

or

PROXY_SERVER='https\t127.0.0.1:1080'

If you do not have proxy you can set pip souce

Tsinghua pip source

PIP_SOURCE='https://pypi.tuna.tsinghua.edu.cn/simple'

or USTC pip source

PIP_SOURCE='https://mirrors.ustc.edu.cn/pypi/web/simple'


here I set the pip source to tsinghua university pip source

## Usage
sudo bash install-tensorflow.sh


## Others
Please feel free to issue problems
