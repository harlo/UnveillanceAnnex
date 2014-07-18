#! /bin/bash
THIS_DIR=`pwd`

if [ $# -eq 0 ]
then
	LAUNCH_ANNEX=true
	WITH_CONFIG=0
else
	LAUNCH_ANNEX=false
	WITH_CONFIG=$1
fi

wget -O lib/anaconda.sh http://09c8d0b2229f813c1b93-c95ac804525aac4b6dba79b00b39d1d3.r79.cf1.rackcdn.com/Anaconda-2.0.1-Linux-x86_64.sh
chmod +x lib/anaconda.sh
echo "**************************************************"
echo "Installing Python Framework via ANACONDA"

sleep 10
./lib/anaconda.sh

sleep 3
ANACONDA=$(grep -i "anaconda" ~/.bashrc)
echo $ANACONDA >> ~/.bash_profile
source ~/.bash_profile
sleep 3

pip install --upgrade -r requirements.txt

cd lib/Core
pip install --upgrade -r requirements.txt

cd $THIS_DIR/lib
mkdir dstk
wget -O dstk/dstk.zip http://www.datasciencetoolkit.org/python_tools.zip
unzip dstk/dstk.zip -d dstk
rm -rf dstk/__MACOSX
cd dstk/python
python setup.py install

cd $THIS_DIR
echo "**************************************************"
python setup.py $WITH_CONFIG

sleep 2
if $LAUNCH_ANNEX; then
	source ~/.bashrc
	chmod 0400 conf/*
	python unveillance_annex.py -firstuse
fi
