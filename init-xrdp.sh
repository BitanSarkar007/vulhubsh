sudo useradd -s /bin/bash -d /opt/bit -m bit
sudo usermod -aG sudo bit

sudo -u bit -i

sudo apt update
sudo apt install xfce4 xfce4-goodies -y
sudo apt install xrdp -y
sudo systemctl start xrdp
cd ~
echo "xfce4-session" | tee .xsession
sudo systemctl restart xrdp
