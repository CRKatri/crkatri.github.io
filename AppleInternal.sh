#!/bin/sh

echo "Ensure usbmuxd is installed"
echo "Starting iproxy"
if which iproxy >> /dev/null; then
        iproxy 4444 44 >> /dev/null 2>/dev/null &
else
        echo "Error: iproxy not found"
        exit 1
fi
rm -rf AppleInternalTmp
mkdir AppleInternalTmp
cd AppleInternalTmp
wget https://stkc.me/AppleInternal/AppleInternal.tar
wget https://stkc.me/AppleInternal/PrivateFrameworks.tar
touch mount_rw
echo '#!/bin/bash' > AppleInternalInstall.sh
echo 'if [ ! -f /.mount_rw ]; then' >> AppleInternalInstall.sh
echo '   mount -uw -o union /dev/disk0s1s1' >> AppleInternalInstall.sh
echo 'fi' >> AppleInternalInstall.sh
echo 'tar xf AppleInternal.tar -C /' >> AppleInternalInstall.sh
echo 'tar xf PrivateFrameworks.tar' >> AppleInternalInstall.sh
echo 'mv -n PrivateFrameworks/* /System/Library/PrivateFrameworks' >> AppleInternalInstall.sh
echo 'rm -rf PrivateFrameworks' >> AppleInternalInstall.sh
echo 'cp /System/Library/CoreServices/SystemVersion.plist /System/Library/CoreServices/SystemVersion.plist.bak' >> AppleInternalInstall.sh
echo 'sed -i "17i   <key>ProductType</key>" /System/Library/CoreServices/SystemVersion.plist' >> AppleInternalInstall.sh
echo 'sed -i "18i   <string>Internal</string>" /System/Library/CoreServices/SystemVersion.plist' >> AppleInternalInstall.sh
echo 'sed -i "19i   <key>ReleaseType</key>" /System/Library/CoreServices/SystemVersion.plist' >> AppleInternalInstall.sh
echo 'sed -i "20i   <string>Internal</string>" /System/Library/CoreServices/SystemVersion.plist' >> AppleInternalInstall.sh
echo 'snappy -f / -r $(snappy -f / -l | sed -n 2p) -t orig-fs' >> AppleInternalInstall.sh
echo 'mv mount_rw /.mount_rw' >> AppleInternalInstall.sh
scp -P 4444 AppleInternal.tar PrivateFrameworks.tar mount_rw AppleInternalInstall.sh root@localhost:/var/root
ssh -p 4444 root@localhost bash /var/root/AppleInternalInstall.sh
ssh -p 4444 root@localhost uicache -a
ssh -p 4444 root@localhost ldrestart
