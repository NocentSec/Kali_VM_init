# Kali_VM_init
We run this on a fresh kali vm
```
git clone https://github.com/ipv6-feet-under/Kali_VM_init\
&& cd Kali_VM_init \
&& chmod +x start.sh \
&& ./start.sh
```

## What it does:

* updates the system
* changes keyboard layout to german
* downloads winpeas and linpeas
* installs stego-toolkit, postman, ngrok, sublime text, chisel
* create symlink to wordlists
* unpacks rockyou
* prompts to install wappalyzer


## TODO:

* add VM_ip  to taskbar automatically
* add PwnTools
* add RSAtools
* make wappalyzer installation automatically
* change keyboard layout to user input not to german