#!/usr/bin/env bash

# author xizero00

# if you have proxy such as shadowsocks you can set proxy settings
# if USE_PROXYCHAIN=1 then it will use proxychains to install tensorflow-gpu
# you have to set proxy server address
# else it will use tsinghua university pip source to install tensorflow-gpu
USE_PROXYCHAIN=
PROXY_SERVER='http\t127.0.0.1:1080'
PIP_SOURCE='https://pypi.tuna.tsinghua.edu.cn/simple'

if [ $USE_PROXYCHAIN ]
then

	# setup proxychains
	sudo apt -y  install proxychains

	# check whether proxychains is running
	existpid=`ps -al | grep "proxychains"|wc -l`
	if [ -gt $existpid ]
	then
		pid=`ps -al |grep "proxychains" | awk '{print $4}'`
		sudo kill -9 ${pid}
	fi

	# check whether conf file exists
	if [ -f "/etc/proxychains.conf" ]; then
		sudo mv /etc/proxychains.conf /etc/proxychains.conf.bak
	fi

	# write conf file
	echo -e "strict_chain\nproxy_dns\ntcp_read_time_out 15000\ntcp_connect_time_out 8000\n[ProxyList]\n${PROXY_SERVER}" |sudo tee /etc/proxychains.conf

	#sudo echo -e "strict_chain\nproxy_dns\ntcp_read_time_out 15000\ntcp_connect_time_out 8000\n[ProxyList]\nhttp\t127.0.0.1:1080" > /etc/proxychains.conf


	# install in python3
	sudo apt -y install ipython3
	sudo apt -y install python3-pip

	sudo -H proxychains pip3 install -U pip
	sudo apt -y remove python3-pip

	sudo -H proxychains pip3 install -U tensorflow-gpu

	# install in python2
	sudo cp /usr/local/bin/pip2 /usr/local/bin/pip
	sudo apt -y install ipython2
	sudo apt -y install python-pip
	sudo -H proxychains pip2 install -U pip
	sudo apt -y remove python-pip

	sudo -H proxychains pip2 install -U tensorflow-gpu
	
	echo 'check python2 dependency'
	sudo -H proxychains pip2 install -i check
	echo 'check python3 dependency'
	sudo -H proxychains pip3 install -i check
	
else
	# using tsinghua university pip source
	# install in python3
	sudo apt -y install ipython3
	sudo apt -y install python3-pip

	sudo -H pip3 install -i ${PIP_SOURCE} -U pip
	sudo apt -y remove python3-pip
	
	sudo -H pip3 install -i ${PIP_SOURCE} -U tensorflow-gpu
	
	# install in python2
	sudo cp /usr/local/bin/pip2 /usr/local/bin/pip
	sudo apt -y  install ipython
	sudo apt -y  install python-pip
	sudo -H pip2 install -i ${PIP_SOURCE} -U pip
	sudo apt -y remove python-pip
	sudo -H pip2 install -i ${PIP_SOURCE} -U tensorflow-gpu
	
	echo 'check python2 dependency'
	sudo -H pip2 install -i ${PIP_SOURCE} check
	echo 'check python3 dependency'
	sudo -H pip3 install -i ${PIP_SOURCE} check
	
fi



echo "tensorflow-gpu installed in python2 and python3"
echo "you can type ipython2 and ipython3 to test it"