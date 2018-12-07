echo "deb http://deb.debian.org/debian stretch-backports main contrib non-free" | tee -a /etc/apt/sources.list

apt update -y
apt upgrade -y

apt -t stretch-backports install -y golang
apt install -y git byobu at libcurl4-openssl-dev libssl-dev python3-pip python3-libtrace nginx

go get pathspider.net/hellfire
go get github.com/docopt/docopt-go
go install pathspider.net/hellfire/cmd/hellfire

go get github.com/britram/canid
go install github.com/britram/canid/canid

git clone https://github.com/mami-project/pathspider
cd pathspider
pip3 install `cat requirements.txt`
python3 setup.py install

echo "root: brian@trammell.ch" | tee -a /etc/aliases
