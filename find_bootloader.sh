echo GRUB :
dd if=/dev/sda bs=512 count=1 2>&1 | grep GRUB
echo LILO :
dd if=/dev/sda bs=512 count=1 2>&1 | grep LILO

