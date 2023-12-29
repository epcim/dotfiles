brew install wimlib
diskutil list external

diskutil eraseDisk MS-DOS "WINUSB" MBR disk2

# win11
hdiutil mount ~/Downloads/Win11_23H2_Czech_x64.iso
rsync -avh --progress --exclude=sources/install.wim /Volumes/CCCOMA_X64FRE_CS-CZ_DV9/* /Volumes/WINUSB
rsync -avh --progress --exclude=sources/install.wim /Volumes/CCCOMA_X64FRE_CS-CZ_DV9/.* /Volumes/WINUSB
mkdir /Volumes/WINUSB/sources/
wimlib-imagex split /Volumes/CCCOMA_X64FRE_CS-CZ_DV9/sources/install.wim /Volumes/WINUSB/sources/install.swm 4000

ls -la /Volumes/WINUSB

diskutil unmount /dev/disk2
diskutil unmountDisk /dev/disk2
