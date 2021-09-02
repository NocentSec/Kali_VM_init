#!/bin/bash

red=$(tput setaf 196)
green=$(tput setaf 34)
blue=$(tput setaf 27)
reset=$(tput setaf 234)
reset_final=$(tput sgr0)

echo "$red Which language would you like you keyboard layout to be?"
select lang in "de" "us"; do
    case $lang in
        de ) LANG="de"; sudo timedatectl set-timezone Europe/Berlin;break;;
        en ) LANG="us";break;;
    esac
done

# change keyboard layout to german
echo "$blue Setting your keyboard layout...$reset"
setxkbmap -layout $LANG
echo "setxkbmap -layout $LANG" >> "$HOME/.zshrc"
echo "$green Setting your keyboard layout...done!$reset"


echo "$red Where do you want to save your scripts?"
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

#update everything
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt upgrade -y

#download scripts

##PEASS
echo "$blue Downloading PEASS...$reset"
mkdir "${PATHSET}/PEASS"
git clone https://github.com/carlospolop/PEASS-ng "${PATHSET}/PEASS"
echo "$green Downloading PEASS...done!$reset"

##rockyou and wordlists link
echo "$blue Decompress rockyou and create symlink to wordlists..."
sudo gzip -d /usr/share/wordlists/rockyou.txt.gz
ln -s /usr/share/wordlists "${PATHSET}/wordlists"
echo "$green Decompress rockyou and create symlink to wordlists...done!$reset"

##get postman
echo "$blue Downloading postman..."
wget -O "/tmp/Postman" https://dl.pstmn.io/download/latest/linux64 
tar -xzvf "/tmp/Postman" -C ${PATHSET}
rm "/tmp/Postman"
echo "$green Downloading postman...done!$reset"


##sublime text
echo "$blue Downloading sublime..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https -y
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update -y
sudo apt-get install sublime-text -y
echo "$green Downloading postman...done!$reset"


##ngrok
echo "$blue Downloading ngrok..."
wget -O "/tmp/ngrok.zip" https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
sudo unzip "/tmp/ngrok" -d "/usr/bin/"
rm "/tmp/ngrok.zip"
echo "$green Downloading ngrok...done!$reset"

##chisel
echo "$blue Downloading chisel..."
curl https://i.jpillora.com/chisel! | sudo bash
echo "$green Downloading chisel...done!$reset"

##stego-toolkit
echo "$blue Downloading stego-toolkit..."
sudo apt install docker.io -y
sudo docker pull dominicbreuker/stego-toolkit
echo "sudo docker run -it --rm -v $HOME/Downloads:/data dominicbreuker/stego-toolkit /bin/bash" > "${PATHSET}/stego-toolkit.sh"
chmod +x "${PATHSET}/stego-toolkit.sh"
echo "$green Downloading stego-toolkit...done!$reset"

##open wappalyzer webpage
echo "$blue Opening Wappalyzer extension in firefox click on Add to Firefox"
firefox https://addons.mozilla.org/en-US/firefox/addon/wappalyzer/
echo "$red Close Firefox to continuie..$reset"

## ip monitor in taskbar for VM
echo "$green All done!$reset"
echo "$green add a new GenMon panel to your taskbar and make it display the output of this command: $red/bin/bash -c \"hostname -I | tail -1 | cut -d ' ' -f 3\"$reset"
echo "$green dont forget to run ngrok auth token thingy$reset_final"