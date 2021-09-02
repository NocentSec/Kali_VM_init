#!/bin/bash

# change keyboard layout to german
echo "Setting your keyboard layout to german..."
setxkbmap -layout de
echo "setxkbmap -layout de" >> "$HOME/.zshrc"
echo "Setting your keyboard layout to german...done!"

#update everything
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt upgrade -y

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
echo "Downloading PEASS..."
mkdir "${PATHSET}/PEASS"
git clone https://github.com/carlospolop/PEASS-ng "${PATHSET}/PEASS"
echo "Downloading PEASS...done!"

##rockyou and wordlists link
echo "Decompress rockyou and create symlink to wordlists..."
gzip -d /usr/share/wordlists/rockyou.txt.gz
ln -s /usr/share/wordlists "${PATHSET}/wordlists"
echo "Decompress rockyou and create symlink to wordlists...done!"

##open wappalyzer webpage
echo "Opening Wappalyzer extension in firefox click on Add to Firefox"
firefox https://addons.mozilla.org/en-US/firefox/addon/wappalyzer/


##get postman
echo "Downloading postman..."
wget -O "/tmp/Postman" https://dl.pstmn.io/download/latest/linux64 
tar -xzvf "/tmp/Postman" -C ${PATHSET}
rm "/tmp/Postman"
echo "Downloading postman...done!"


##sublime text
echo "Downloading sublime..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https -y
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update -y
sudo apt-get install sublime-text -y
echo "Downloading postman...done!"


##ngrok
echo "Downloading ngrok..."
wget -O "/tmp/ngrok.zip" https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
sudo unzip "/tmp/ngrok" -d "/usr/bin/"
rm "/tmp/ngrok.zip"
echo "Downloading ngrok...done!"

##chisel
echo "Downloading chisel..."
curl https://i.jpillora.com/chisel! | bash
echo "Downloading chisel...done!"


##stego-toolkit
echo "Downloading stego-toolkit..."
sudo apt install docker.io -y
sudo docker pull dominicbreuker/stego-toolkit
echo "sudo docker run -it --rm -v $HOME/Downloads:/data dominicbreuker/stego-toolkit /bin/bash" > "${PATHSET}/stego-toolkit.sh"
chmod +x "${PATHSET}/stego-toolkit.sh"
echo "Downloading stego-toolkit...done!"

## ip monitor in taskbar for VM
echo "add a new GenMon panel to your taskbar and make it display the output of this command: /bin/bash -c \"hostname -I | tail -1 | cut -d ' ' -f 3\""
echo "dont forget to run ngrok auth token thingy"