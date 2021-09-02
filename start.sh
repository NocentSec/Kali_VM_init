#!/bin/bash

red=$(tput setaf 196)
green=$(tput setaf 34)
blue=$(tput setaf 27)
reset=$(tput sgr0)

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
rm -r -f "${PATHSET}/PEASS/build_lists"
rm -r -f "${PATHSET}/PEASS/parser"
rm -f "${PATHSET}/PEASS/CONTRIBUTING.md"
rm -f "${PATHSET}/PEASS/LICENSE"
rm -f "${PATHSET}/PEASS/README.md"
rm -r -f "${PATHSET}/PEASS/linPEAS/builder"
rm -r -f "${PATHSET}/PEASS/linPEAS/images"
rm -f "${PATHSET}/PEASS/linPEAS/README.md"
rm -f "${PATHSET}/PEASS/winPEAS/README.md"
mv "${PATHSET}/PEASS/winPEAS/winPEASexe/binaries/x64/Release/winPEASx64.exe"  "${PATHSET}/PEASS/winPEAS/winPEASx64.exe"
mv "${PATHSET}/PEASS/winPEAS/winPEASexe/binaries/x86/Release/winPEASx86.exe"  "${PATHSET}/PEASS/winPEAS/winPEASx86.exe"
rm -r -f "${PATHSET}/PEASS/winPEAS/winPEASexe"
mv "${PATHSET}/PEASS/winPEAS/winPEASbat/winPEAS.bat"  "${PATHSET}/PEASS/winPEAS/winPEAS.bat"
rm -r -f "${PATHSET}/PEASS/winPEAS/winPEASbat"
rm -r -f "${PATHSET}/PEASS/.git"
rm -r -f "${PATHSET}/PEASS/.github"
rm -f "${PATHSET}/PEASS/.gitignore"
echo "$green Downloading PEASS...done!$reset"

##rockyou and wordlists link
echo "$blue Decompress rockyou and create symlink to wordlists...$reset"
sudo gzip -d /usr/share/wordlists/rockyou.txt.gz
ln -s /usr/share/wordlists "${PATHSET}/wordlists"
echo "$green Decompress rockyou and create symlink to wordlists...done!$reset"

##get postman
echo "$blue Downloading postman...$reset"
wget -O "/tmp/Postman" https://dl.pstmn.io/download/latest/linux64 
tar -xzvf "/tmp/Postman" -C ${PATHSET}
rm "/tmp/Postman"
echo "$green Downloading postman...done!$reset"


##sublime text
echo "$blue Downloading sublime...$reset"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https -y
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update -y
sudo apt-get install sublime-text -y

echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Sublime Text
GenericName=Text Editor
Comment=Sophisticated text editor for code, markup and prose
Exec=/opt/sublime_text/sublime_text %F
Terminal=false
MimeType=text/plain;
Icon=sublime-text
Categories=TextEditor;Development;
StartupNotify=true
Actions=new-window;new-file;
X-XFCE-Source=file:///usr/share/applications/sublime_text.desktop

[Desktop Action new-window]
Name=New Window
Exec=/opt/sublime_text/sublime_text --launch-or-new-window
OnlyShowIn=Unity;

[Desktop Action new-file]
Name=New File
Exec=/opt/sublime_text/sublime_text --command new_file
OnlyShowIn=Unity;" > $HOME/.config/xfce4/panel/launcher-6/16224464981.desktop

echo "$green Downloading sublime...done!$reset"


##ngrok
echo "$blue Downloading ngrok...$reset"
wget -O "/tmp/ngrok.zip" https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
sudo unzip "/tmp/ngrok" -d "/usr/bin/"
rm "/tmp/ngrok.zip"
echo "$green Downloading ngrok...done!$reset"

##chisel
echo "$blue Downloading chisel...$reset"
curl https://i.jpillora.com/chisel! | sudo bash
echo "$green Downloading chisel...done!$reset"

##stego-toolkit
echo "$blue Downloading stego-toolkit...$reset"
sudo apt install docker.io -y
sudo docker pull dominicbreuker/stego-toolkit
echo "sudo docker run -it --rm -v $HOME/Downloads:/data dominicbreuker/stego-toolkit /bin/bash" > "${PATHSET}/stego-toolkit.sh"
chmod +x "${PATHSET}/stego-toolkit.sh"
echo "$green Downloading stego-toolkit...done!$reset"

##python3 pip
echo "$blue installing python3 pip...$reset"
sudo apt install python3-pip -y
echo "$green installing python3 pip...done!$reset"

##rsactftool
echo "$blue downloading rsaCTFtool...$reset"
git clone https://github.com/Ganapati/RsaCtfTool.git "${PATHSET}/RsaCtfTool"
sudo apt-get install libgmp3-dev libmpc-dev -y
pip3 install -r "${PATHSET}/RsaCtfTool/requirements.txt"
sudo pip3 install pycryptodome
sudo pip3 install egcd
echo "$green downloading rsaCTFtool pip...done!$reset"

##pwntools
echo "$blue downloading pwntools...$reset"
sudo apt-get update
sudo apt-get install python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential -y
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pwntools
echo "$green downloading pwntools...done!$reset"

##open wappalyzer webpage
echo "$blue Opening Wappalyzer extension in firefox click on Add to Firefox"
echo "$red Close Firefox to continuie..$reset"
firefox https://addons.mozilla.org/en-US/firefox/addon/wappalyzer/ 2>/dev/null


## ip monitor in taskbar for VM
echo "$green All done!$reset"
echo "$green add a new GenMon panel to your taskbar and make it display the output of this command: $red/bin/bash -c \"hostname -I | tail -1 | cut -d ' ' -f 3\"$reset"
echo "$green dont forget to run ngrok auth token thingy$reset"