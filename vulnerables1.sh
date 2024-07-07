echo -e "\e[1;31m updating repos \e[0m" 
apt update

#echo -e "\e[1;31m Upgrading repos \e[0m" 
#apt upgrade -y

echo -e "\e[1;31m  Install the latest version docker \e[0m" 
curl -s https://get.docker.com/ | sh

echo -e "\e[1;31m  Run docker service \e[0m" 
systemctl start docker

echo -e "\e[1;31m Clone Vulnerables file \e[0m"

git clone https://github.com/BitanSarkar007/vulhubsh.git
cd vulhubsh

echo -e "\e[1;31m Give executive permission \e[0m"

chmod +x vulnerables1.sh

echo -e "\e[1;31m Clone vulhub \e[0m"

git clone https://github.com/BitanSarkar007/vulhub.git

echo -e "\e[1;31m Start vulhub \e[0m"

bash vulnerables1.sh start