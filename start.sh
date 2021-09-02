#!/bin/bash

# check if sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# change keyboard layout to german
setxkbmap -layout de

#update everything
apt update
apt dist-upgrade
apt upgrade

#download scripts

echo "Where do you want to save your scripts?"
select script_path in "Home" "Desktop" "Documents" "Downloads"; do
    case $script_path in
        Home ) PATHSET="$HOME/";break;;
        Desktop ) PATHSET="$HOME/Desktop/";break;;
        Documents ) PATHSET="$HOME/Documents/";break;;
        Downloads ) PATHSET="$HOME/Downloads/";break;;
    esac
done
PATHSET="${PATHSET}Scripts";
mkdir $PATHSET

##PEASS
mkdir "${PATHSET}/PEASS"
git clone https://github.com/carlospolop/PEASS-ng "${PATHSET}/PEASS"

##rockyou and wordlists link
gzip -d /usr/share/wordlists/rockyou.txt.gz
ln -s /usr/share/wordlists "${PATHSET}/wordlists"

##open wappalyzer webpage

firefox https://addons.mozilla.org/en-US/firefox/addon/wappalyzer/

##get postman

wget -O "/tmp/Postman" https://dl.pstmn.io/download/latest/linux64 
tar -xzvf "/tmp/Postman" -C ${PATHSET}
rm "/tmp/Postman"

##sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt-get update
apt-get install sublime-text

##ngrok
wget -O "/tmp/ngrok.zip" https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip "/tmp/ngrok" -d "/usr/bin/"
rm "/tmp/ngrok.zip"


##chisel

curl https://i.jpillora.com/chisel! | bash

##stego-toolkit
apt install docker.io
docker pull dominicbreuker/stego-toolkit
echo "sudo docker run -it --rm -v $HOME/Downloads:/data dominicbreuker/stego-toolkit /bin/bash" > "${PATHSET}/stego-toolkit.sh"
chmod +x "${PATHSET}/stego-toolkit.sh"

echo "dont forget to run ngrok auth token thingy"